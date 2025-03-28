pipeline {
    agent any
    environment {
        AWS_ACCESS_KEY_ID = credentials('aws_access_key')  
        AWS_SECRET_ACCESS_KEY = credentials('aws_secret_key')
    }
    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', credentialsId: 'your-credentials-id', url: 'https://github.com/Charanraj2498/terraform-workspace.git'
            }
        }

        stage('Setup AWS Credentials') {
            steps {
                sh '''
                mkdir -p /home/ubuntu/.aws
                echo "[default]" > /home/ubuntu/.aws/credentials
                echo "aws_access_key_id = $AWS_ACCESS_KEY_ID" >> /home/ubuntu/.aws/credentials
                echo "aws_secret_access_key = $AWS_SECRET_ACCESS_KEY" >> /home/ubuntu/.aws/credentials
                chmod 600 /home/ubuntu/.aws/credentials
                '''
            }
        }
        
        stage('Terraform Init & Apply') {
            steps {
                sh '''
                terraform init
                terraform apply -auto-approve
                '''
            }
        }

        stage('Fetch Public IP & Create Inventory') {
            steps {
                sh '''
                echo "[ec2-instance]" > inventory
                terraform output public_ip >> inventory
                '''
            }
        }

        stage('Run Ansible Playbook') {
            steps {
                sh 'ansible-playbook -i inventory playbook.yml'
            }
        }
    }
}
