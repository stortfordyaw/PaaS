pipeline {
    agent node {
        label "master"
    }

    stages {
        stage('Feth_latest code') {
            steps {
                 git credentialsId: 'Github', url: 'https://github.com/stortfordyaw/PaaS'
            }
        }
        stage('TF Init&Plan') {
            steps {
                sh 'terraform init'
                sh 'terraform plan'
            }
        }
        stage('Approval') {
            steps {
                script {
                     def userInput = input(id: 'confirm', message: 'Apply Terraform?', parameters: [ [$class: 'BooleanParameterDefinition', defaultValue: false, description: 'Apply terraform', name: 'confirm'] ])
                }
            }
        }
        stage('TF Apply') {
            steps 'terraform apply -input=false'
        }
    }
}
