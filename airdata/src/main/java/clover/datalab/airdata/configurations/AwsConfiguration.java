package clover.datalab.airdata.configurations;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;

import com.amazonaws.auth.AWSCredentials;
import com.amazonaws.auth.AWSStaticCredentialsProvider;
import com.amazonaws.auth.BasicAWSCredentials;
import com.amazonaws.regions.Regions;
import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.AmazonS3ClientBuilder;

import lombok.RequiredArgsConstructor;

@Configuration 
@RequiredArgsConstructor
public class AwsConfiguration {
	
	@Value("${cloud.aws.access.key}")
	private String access;
	
	@Value("${cloud.aws.secret.key}")
	private String secret;
	
	public AmazonS3 s3Client() {
		return AmazonS3ClientBuilder.standard()
									.withCredentials(new AWSStaticCredentialsProvider(getCredentials()))
									.withRegion(Regions.AP_NORTHEAST_2)
									.build();
	}
	
	private AWSCredentials getCredentials() {
		return new BasicAWSCredentials(access, secret);
	}

}
