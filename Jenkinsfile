pipeline {
    agent any
    environment {
        _PATH_TF = "NodejsApp_GCP"
        _TFACTION = "apply"
        GCP_PROJECT_ID = 'gcp-cloudrun-nodejs-mysql-app'      
        GCP_CREDENTIALS = credentials('gcp-service-account-key') 
        GIT_CREDENTIALS_ID = 'git-credentials-id'
        GIT_REPO_URL = 'https://github.com/anitamaharana55/NodejsApp_GCP.git'
    }
    stages {
        stage('Authenticate to GCP') {
            steps {
                // Using the GCP service account key as a secret file
                withCredentials([file(credentialsId: 'gcp-service-account-key', variable: 'GCP_KEY_FILE')]) {
                    script {
                        // Authenticate using the secret file path
                        sh 'gcloud auth activate-service-account --key-file=$GCP_KEY_FILE'
                        sh 'gcloud config set project ${GCP_PROJECT_ID}'
                    }
                }
            }
        }
        stage('Checkout Code') {
            steps {
                // Cloning the repository
                checkout([$class: 'GitSCM', 
                    branches: [[name: '*/main']],          
                    userRemoteConfigs: [[url: "${GIT_REPO_URL}", credentialsId: "${GIT_CREDENTIALS_ID}"]]
                ])
            }
        }
        stage('Install dependencies') {
            steps {
                script {
                    // Make sure you're using the correct Python version
                    sh 'python3 -m venv venv'  // Create a virtual environment
                    sh './venv/bin/pip install --upgrade pip'  // Upgrade pip in virtualenv
                    sh './venv/bin/pip install -r requirements.txt'  // Install dependencies
                }
            }
        }
        // stage('Checkov Scan') {
        //     steps {
        //         sh 'pip install checkov'
        //         sh 'checkov --version'
        //         sh 'checkov -d . --output json --output-file checkov_report.json --quiet || (echo "Checkov scan failed!" && exit 1)'
        //     }
        // }
        // stage('Terraform Init') {
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