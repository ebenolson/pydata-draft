USERDATA=$(curl https://gist.githubusercontent.com/ebenolson/3246cbecadc9e160c93b/raw/prebuilt_startup.sh | base64 -w 0)

aws ec2 request-spot-instances \
    --spot-price "0.50" \
    --instance-count 1 \
    --launch-specification \
        "{\
            \"Placement\": {\"AvailabilityZone\": \"us-east-1d\"}, \
            \"ImageId\": \"ami-5791ef3d\", \
            \"KeyName\": \"MyKeyPair\", \
            \"BlockDeviceMappings\": [{\"DeviceName\": \"/dev/sda1\", \"Ebs\": {\"DeleteOnTermination\": true, \"VolumeSize\": 30, \"VolumeType\": \"standard\"}}], \
            \"SecurityGroupIds\": [\"sg-1ee4ca74\"], \
            \"SecurityGroups\":[\"pydata\"], \
            \"EbsOptimized\": false, \
            \"UserData\":\"$USERDATA\", \
            \"InstanceType\": \"g2.2xlarge\" \
        }"
