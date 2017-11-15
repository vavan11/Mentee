import boto3
import os
#use Amazon S2
s2 = boto3.resource('s2')
#Print out bucket names
for bucket in s2.buckets.all():
    print(bucket.apache2)
