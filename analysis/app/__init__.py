from flask import Flask, request, jsonify
import pandas as pd
from sklearn.preprocessing import StandardScaler, MinMaxScaler
import torch
import torch.nn as nn
from torch.autograd import Variable
import joblib
import datetime


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
        
    result = getData(param)

    print(result)

    return jsonify(result)

if __name__ == "__main__" :
    app.run(host='0.0.0.0', port=5000)

def getData(param) :
    device = torch.device('cuda:0' if torch.cuda.is_available() else 'cpu')
    torch.manual_seed(3)
    if device == "cuda:0":
        torch.cuda.manual_seed_all(3)

    today = datetime.date.today()
    tomorrow = today + datetime.timedelta(days=1)
    tdat = today + datetime.timedelta(days=2)

    arg1 = param.get(tomorrow.strftime("%Y%m%d"))
    arg2 = param.get(tdat.strftime("%Y%m%d"))

    X_act = pd.DataFrame({
        '미세먼지(PM10)' : [arg1.get('미세먼지(PM10)'), arg2.get('미세먼지(PM10)')],
        '초미세먼지(PM25)' : [arg1.get('초미세먼지(PM25)'), arg2.get('초미세먼지(PM25)')],
        '평균습도(%rh)' : [arg1.get('평균습도(%rh)'), arg2.get('평균습도(%rh)')],
        '평균풍속(m/s)' : [arg1.get('평균풍속(m/s)'), arg2.get('평균풍속(m/s)')],
        '최대풍속풍향(deg)' : [arg1.get('최대풍속풍향(deg)'), arg2.get('최대풍속풍향(deg)')],
        '강수량(mm)' : [arg1.get('강수량(mm)'), arg2.get('강수량(mm)')],
        '평균기온(℃)' : [arg1.get('평균기온(℃)'), arg2.get('평균기온(℃)')],
        'humid_nextDay' : [arg1.get('humid_nextDay'), arg2.get('humid_nextDay')], # 내일 습도
        'wv_nextDay' : [arg1.get('wv_nextDay'), arg2.get('wv_nextDay')], # 내일 풍속
        'wd_nextDay' : [arg1.get('wd_nextDay'), arg2.get('wd_nextDay')], # 내일 최대풍속풍향
        'pop_nextDay' : [arg1.get('pop_nextDay'), arg2.get('pop_nextDay')], # 내일 강수량
        'at_nextDay' : [arg1.get('at_nextDay'), arg2.get('at_nextDay')], # 내일 평균온도
        'ht_nextDay' : [arg1.get('ht_nextDay'), arg2.get('ht_nextDay')] # 내일 최고온도
    })

    ss = joblib.load("app/scaler/ss_"+arg1.get('지역1')+".pkl")
    ms = joblib.load("app/scaler/ms_"+arg1.get('지역1')+".pkl")

    X_act_ss = ss.transform(X_act)
    X_act_tensors = torch.Tensor(X_act_ss)
    X_act_tensors_f = torch.reshape(X_act_tensors, (X_act_tensors.shape[0], 1, X_act_tensors.shape[1]))

    model = LSTM(2, 13, 2, 1, X_act_tensors_f.shape[1])
    model.load_state_dict(torch.load("app/model/LSTM_MODEL_"+arg1.get('지역1')+".pth"))
    model.eval()

    predict = model(X_act_tensors_f)
    predict = predict.data.numpy()
    predict = ms.inverse_transform(predict)
    
    print("predict : ", predict)

    return {tomorrow.strftime("%Y%m%d") : {"PM10" : str(predict[0][0]), "PM25" : str(predict[0][1])},
            tdat.strftime("%Y%m%d") : {"PM10" : str(predict[1][0]), "PM25" : str(predict[1][1])}}

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
        self.fc_4 = nn.Linear(256, 128)
        self.fc_5 = nn.Linear(128, 256)
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