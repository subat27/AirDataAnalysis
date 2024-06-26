from flask import Flask, request, jsonify
import pandas as pd
from sklearn.preprocessing import StandardScaler, MinMaxScaler
import torch
import torch.nn as nn
from torch.autograd import Variable
import joblib


app = Flask(__name__)
app.config["JSON_AS_ASCII"] = False  ## 인코딩

@app.route("/")
def hello_world():
    return "Hello, Python!"

@app.route("/apiTest", methods=['POST'])
def apiTest():
    print("apiTest IN")

    param = request.get_json()

    print('apiTest param : ', param)
    
    arg1 = param.get("미세먼지(PM10)")
    arg2 = param.get('초미세먼지(PM25)')
    arg3 = param.get('평균습도(%rh)')
    arg4 = param.get('평균풍속(m/s)')
    arg5 = param.get('최대풍속풍향(deg)')
    arg6 = param.get('강수량(mm)')
    arg7 = param.get('평균기온(℃)')
    arg8 = param.get('humid_nextDay')
    arg9 = param.get('wv_nextDay')
    arg10 = param.get('wd_nextDay')
    arg11 = param.get('pop_nextDay')
    arg12 = param.get('at_nextDay')
    arg13 = param.get('ht_nextDay')
    arg14 = param.get('td_nextDay')
    local = param.get('지역1')
    
    result = getData(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10,
                     arg11, arg12, arg13, arg14, local)

    print(result)

    return jsonify(result)

if __name__ == "__main__" :
    app.run(host='127.0.0.1', port=5000)

def getData(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10,
                     arg11, arg12, arg13, arg14, local) :

    device = torch.device('cuda:0' if torch.cuda.is_available() else 'cpu')
    torch.manual_seed(3)
    if device == "cuda:0":
        torch.cuda.manual_seed_all(3)

    ss = StandardScaler()
    
    X_act = pd.DataFrame({
        '미세먼지(PM10)' : [arg1],
        '초미세먼지(PM25)' : [arg2],
        '평균습도(%rh)' : [arg3],
        '평균풍속(m/s)' : [arg4],
        '최대풍속풍향(deg)' : [arg5],
        '강수량(mm)' : [arg6],
        '평균기온(℃)' : [arg7],
        'humid_nextDay' : [arg8], # 내일 습도
        'wv_nextDay' : [arg9], # 내일 풍속
        'wd_nextDay' : [arg10], # 내일 최대풍속풍향
        'pop_nextDay' : [arg11], # 내일 강수량
        'at_nextDay' : [arg12], # 내일 평균온도
        'ht_nextDay' : [arg13], # 내일 최고온도
        'td_nextDay' : [arg14]

    })

    X_act_ss = ss.fit_transform(X_act)
    X_act_tensors = torch.Tensor(X_act_ss)
    X_act_tensors_f = torch.reshape(X_act_tensors, (X_act_tensors.shape[0], 1, X_act_tensors.shape[1]))


    model = LSTM(2, 14, 2, 1, X_act_tensors_f.shape[1])

    model.load_state_dict(torch.load("app/model/LSTM_MODEL_"+local+".pth"))
    model.eval()

    ms = joblib.load("app/scaler/ms_"+local+".pkl")

    predict = model(X_act_tensors_f)
    predict = predict.data.numpy()
    predict = ms.inverse_transform(predict)
    
    return {"미세먼지" : str(predict[0][0]), "초미세먼지" : str(predict[0][1])}

class LSTM(nn.Module) :
    def __init__(self, num_classes, input_size, hidden_size, num_layers, seq_length):
        super(LSTM, self).__init__()
        self.num_classes = num_classes
        self.num_layers = num_layers
        self.input_size = input_size
        self.hidden_size = hidden_size
        self.seq_length = seq_length

        self.lstm = nn.LSTM(input_size=input_size, hidden_size=hidden_size, num_layers=num_layers, batch_first=True)
        
        self.fc_1 = nn.Linear(hidden_size, 256)
        self.fc_2 = nn.Linear(256, 512)
        self.fc_3 = nn.Linear(512, 256)
        self.fc = nn.Linear(256, num_classes)

        self.relu = nn.ReLU()

    def forward(self, x) :
        h_0 = Variable(torch.zeros(self.num_layers, x.size(0), self.hidden_size))
        c_0 = Variable(torch.zeros(self.num_layers, x.size(0), self.hidden_size))
        output, (hn, cn) = self.lstm(x, (h_0, c_0))
        hn = hn.view(-1, self.hidden_size)
        out = self.relu(hn)
        out = self.fc_1(out)
        out = self.relu(out)
        out = self.fc(out)
        return out




