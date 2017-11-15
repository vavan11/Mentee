import boto3
import os
from botocore.exceptions import ClientError

# Create a Security Group and Rules
##  http://boto3.readthedocs.io/en/latest/guide/ec2-example-security-group.html

ec2 = boto3.client('ec2')
response = ec2.describe_vpcs()
vpc_id = response.get('Vpcs', [{}])[0].get('VpcId', '')

try:
    response = ec2.create_security_group(GroupName='SECURITY_GROUP_EC2_MIKRO',
                                         Description='EC2_MIKRO_SG',
                                         VpcId=vpc_id)
    security_group_id = response['GroupId']
    print('Security Group Created %s in vpc %s.' % (security_group_id, vpc_id))

    data = ec2.authorize_security_group_ingress(
        GroupId=security_group_id,
        IpPermissions=[
            {'IpProtocol': 'tcp',
             'FromPort': 80,
             'ToPort': 80,
             'IpRanges': [{'CidrIp': '0.0.0.0/0'}]},
            {'IpProtocol': 'tcp',
             'FromPort': 22,
             'ToPort': 22,
             'IpRanges': [{'CidrIp': '0.0.0.0/0'}]}
        ])
    print('Ingress Successfully Set %s' % data)
except ClientError as e:
    print(e)

#Launching New Instances
##  https://stackoverflow.com/questions/41518334/how-do-i-use-boto3-to-launch-an-ec2-instance-with-an-iam-role

ec2_instance = boto3.resource('ec2')
ec2_instance.create_instances(InstanceType='t2.micro',
                              MinCount=1, MaxCount=1,
                              SecurityGroupIds=['security_group_id'],)
