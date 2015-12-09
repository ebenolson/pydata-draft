USERDATA=$(curl https://gist.githubusercontent.com/ebenolson/3246cbecadc9e160c93b/raw/setup.sh | base64 -w 0)

aws ec2 request-spot-instances \
    --spot-price "0.35" \
    --instance-count 1 \
    --launch-specification \
        "{\
            \"Placement\": {\"AvailabilityZone\": \"us-east-1d\"}, \
            \"ImageId\": \"ami-d05e75b8\", \
            \"KeyName\": \"MyKeyPair\", \
            \"BlockDeviceMappings\": [{\"DeviceName\": \"/dev/sda1\", \"Ebs\": {\"DeleteOnTermination\": true, \"VolumeSize\": 30, \"VolumeType\": \"standard\"}}], \
            \"SecurityGroupIds\": [\"sg-1ee4ca74\"], \
            \"SecurityGroups\":[\"pydata\"], \
            \"EbsOptimized\": false, \
            \"UserData\":\"$USERDATA\", \
            \"InstanceType\": \"g2.2xlarge\" \
        }"
