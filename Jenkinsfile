pipeline {
    agent { node { label 'terraform-node' } } 
    parameters {
                choice(name: 'Deployment_Type', choices:['apply','destroy'],description:'The deployment type')
                  }
    environment {
        EMAIL_TO = 'bolarinwaibrahimo@gmail.com'
    }
    stages {
        stage('1.Terraform init') {
            steps {
                echo 'terraform init phase'
                sh 'terraform init'
            }
        }
        stage('2.Terraform plan') {
            steps {
                echo 'terraform plan phase'
                sh 'AWS_REGION=eu-west-2 terraform plan'
            }
        }
        stage('3.Manual Approval') {
            input {
                message "Should we proceed?"
                ok "Yes, we should."
                parameters{
                    choice (name: 'Manual_Approval', choices: ['Approve','Reject'], description: 'Approve or Reject the deployment')
                }
            }
             steps {
                echo "Deployment ${Manual_Approval}"
            }          
        }
        stage('4.Terraform Deploy') {              
            steps { 
                echo 'Terraform ${params.Deployment_Type} phase'  
                sh 'chmod +x scripts/update-kubeconfig.sh'
                sh 'chmod +x scripts/install_helm.sh'  
                sh "AWS_REGION=eu-west-2 terraform ${params.Deployment_Type} --auto-approve"
                sh("""scripts/update-kubeconfig.sh""")
                sh("""scripts/install_helm.sh""")                  
                }
                }
        stage ('5. Email Notification') {
            steps {
                script {
                try {
                       mail bcc: 'bolarinwaibrahimo@gmail.com', 
                       body: '''Terraform deployment is completed.
                        Let me know if the changes look okay.
                        Thanks,
                        Jide Domain System Technologies,
              +44 7887768539''', cc: 'bolarinwaibrahimo@gmail.com', from: '', replyTo: '', subject: 'Terraform Infra deployment completed!!!', to: 'sarahajibola40@gmail.com'
                          
               }  
               catch (Exception e) {
                        echo "Failed to send email notification: ${e}"
               }  
            }
          }
        } 
     }       
} 
