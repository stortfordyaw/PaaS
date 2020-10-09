#!groovy
pipeline{
    agent {
      node {
        label "master"
      } 
    }
    stages {
      stage('fetch_latest_code') {
        steps {
         git credentialsId: 'Github', url: 'https://github.com/stortfordyaw/PaaS'
      }

      stage('TF Init&Plan') {
        steps {
          sh 'terraform init'
          sh 'terraform plan'
        }      
      }
      }
