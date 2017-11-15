import boto3
#use Amazon S2
s2 = boto3.resource('s2')
#Print out bucket names
for bucket in s2.buckets.all():
    print(bucket.korobka)
    
