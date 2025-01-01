
# Fetch AMIs with names starting with "flask_server_ami"
$amis = aws ec2 describe-images --owners self --region us-east-2 --filters "Name=name,Values=flask_server_ami*" --query "Images[].ImageId" --output text

foreach ($ami_id in $amis) {
    $snapshots = aws ec2 describe-images --image-ids $ami_id --region us-east-2 --query "Images[].BlockDeviceMappings[].Ebs.SnapshotId" --output text
    Write-Output "NOTE: Deregistering AMI: $ami_id"
    aws ec2 deregister-image --image-id $ami_id

    foreach ($snapshot_id in $snapshots) {
        Write-Output "NOTE: Deleting snapshot: $snapshot_id"
        aws ec2 delete-snapshot --snapshot-id $snapshot_id
    }
}
