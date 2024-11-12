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
        // stage('Install dependencies') {
        //     steps {
        //         script {
        //             sh 'python3 -m venv venv'  
        //             sh './venv/bin/pip install --upgrade pip'  
        //         }
        //     }
        // }
        stage("terraform init"){
            steps {
                script {
                                         
                    sh '''
                    echo "Initializing Terraform..."
                    terraform -v  // Check terraform version
                    terraform init -reconfigure                          
                    '''
                    }

        }
            }
        // stage('Terraform Init') {
        //     steps {
        //         script {
        //             def pathTF = "${env.PATH_TF}"  
        //             if (fileExists(pathTF)) {
        //             dir(pathTF) {
        //             sh 'terraform init -reconfigure'
        //             sh 'terraform plan'
        //             }
        //         } else {
        //         echo "Directory '${pathTF}' does not exist. Please verify the path."
        //         error "Terraform initialization failed: Directory not found."
        //     }
        // }
        //     }
        // }
        // stage('Terraform Plan') {
        //     steps {
        //         sh '''
        //             if [ -d '${PATH_TF}' ]; then
        //                 terraform refresh
        //                 terraform plan
        //             else
        //                 for dir in '${PATH_TF}'; do
        //                     cd "${dir}"
        //                     env="${dir%/*}"
        //                     env="${env#*/}"
        //                     echo "${env}"
        //                     terraform plan || exit 1
        //                 done
        //             fi
        //         '''
        //     }
        // }
        // stage('Terraform Apply or Destroy') {
        //     steps {
        //         sh '''
        //             if [ -d '${PATH_TF}' ]; then
        //                 terraform $_TFACTION -auto-approve
        //             else
        //                 echo "$BRANCH_NAME"
        //             fi
        //         '''
        //     }
        // }
    }
}
    