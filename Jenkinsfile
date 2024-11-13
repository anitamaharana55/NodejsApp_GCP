pipeline {
    agent any
    environment {
        PATH_TF = 'NodejsApp_GCP'
        TFACTION = "apply"
        GCP_PROJECT_ID = 'gcp-cloudrun-nodejs-mysql-app'      
        GCP_CREDENTIALS = credentials('gcp-service-account-key') 
        GIT_CREDENTIALS_ID = 'git-credentials-id'
        GIT_REPO_URL = 'https://github.com/anitamaharana55/NodejsApp_GCP.git'
        CLIENT_EMAIL='nodejsdemo@gcp-cloudrun-nodejs-mysql-app.iam.gserviceaccount.com'
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
                        sh 'gcloud auth list'
                        sh 'gcloud config list'
                        
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
            // Install python3-venv package (make sure the system has it installed)
                    sh '''
                        if ! dpkg -l | grep -q python3.11-venv; then
                        sudo apt-get update && sudo apt-get install -y python3.11-venv
                        fi
                    '''
            
            // Create the virtual environment
                    sh 'python3 -m venv venv'  
            
            // Upgrade pip inside the virtual environment
                    sh './venv/bin/pip install --upgrade pip'  
             }
            }
        }

        stage('Checkov Scan') {
            steps {
        // Install Checkov inside the virtual environment
                sh './venv/bin/pip install checkov'

        // Check Checkov version
                sh './venv/bin/checkov --version'

        // Run Checkov scan
                sh './venv/bin/checkov -d . --output json --output-file checkov_report.json --quiet || (echo "Checkov scan failed!" && exit 1)'
            }
        }

        // stage('Install dependencies') {
        //     steps {
        //         script {
        //             sh 'python3 -m venv venv'  
        //             sh './venv/bin/pip install --upgrade pip'  
        //         }
        //     }
        // }
        // stage('Checkov Scan') {
        //     steps {
        //         sh 'pip install checkov'
        //         sh 'checkov --version'
        //         sh 'checkov -d . --output json --output-file checkov_report.json --quiet || (echo "Checkov scan failed!" && exit 1)'
        //     }
        // }
        stage('Terraform Init') {
            steps {
                sh '''
                    terraform init -reconfigure
                '''
        }
            }
        
        stage('Terraform Plan') {
            steps {
                sh '''
                    terraform refresh
                    terraform plan
                '''
            }
        }
        stage('Terraform Apply or Destroy') {
            steps {
                sh '''
                    terraform apply -auto-approve
                '''
            }
        }
    }
}
    