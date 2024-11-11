pipeline {
    agent any
    environment {
        _PATH_TF = "NodejsApp_GCP"
        _TFACTION = "apply"
    }
    stages {
        stage('Checkout') {
            steps {
                git branch: '$BRANCH_NAME', url: 'https://github.com/anitamaharana55/NodejsApp_GCP.git'
            }
        }
        stage('Checkov Scan') {
            steps {
                sh 'pip install --upgrade pip'
                sh 'pip install checkov'
                sh 'checkov --version'
                sh 'checkov -d . --output json --output-file checkov_report.json --quiet || (echo "Checkov scan failed!" && exit 1)'
            }
        }
        stage('Terraform Init') {
            steps {
                sh '''
                    if [ -d "$_PATH_TF" ]; then
                        terraform init -reconfigure
                    else
                        for dir in $_PATH_TF; do
                            cd "${dir}"
                            env="${dir%/*}"
                            env="${env#*/}"
                            echo "${env}"
                            terraform init -reconfigure || exit 1
                        done
                    fi
                '''
            }
        }
        stage('Terraform Plan') {
            steps {
                sh '''
                    if [ -d "$_PATH_TF" ]; then
                        terraform refresh
                        terraform plan
                    else
                        for dir in $_PATH_TF; do
                            cd "${dir}"
                            env="${dir%/*}"
                            env="${env#*/}"
                            echo "${env}"
                            terraform plan || exit 1
                        done
                    fi
                '''
            }
        }
        stage('Terraform Apply or Destroy') {
            steps {
                sh '''
                    if [ -d "$_PATH_TF" ]; then
                        terraform $_TFACTION -auto-approve
                    else
                        echo "$BRANCH_NAME"
                    fi
                '''
            }
        }
    }
    
}