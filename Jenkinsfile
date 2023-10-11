pipeline {
  agent {
    kubernetes {
      yaml '''
        apiVersion: v1
        kind: Pod
        metadata:
          labels:
            jenkins: jenkins-agent
        spec:
          serviceAccountName: jenkins-service-account
          containers:
          - name: jenkins-agent-container
            image: public.ecr.aws/p3z3z5x5/ansible-k8s:1.0
            command:
            - cat
            tty: true
            env:
            - name: DOCKER_HOST
              value: 'tcp://localhost:2375'
          - name: dind-daemon
            image: 'docker:18-dind'
            command:
            - dockerd-entrypoint.sh
            tty: true
            securityContext: 
              privileged: true 
        '''
    }
  }
  triggers {
	  githubPush()
  }
  stages {
    stage('Execute on Jenkins agent') {
      steps {
        container('jenkins-agent-container') {
          sh '''#!/bin/bash
          ./deploy.sh
          '''
        }
      }
    }
  }
  //   post {
//     success {
//       slackSend color: '#36a64f', message: "Deployment of myapp to production succeeded!"
//     }
//     failure {
//       slackSend color: '#ff0000', message: "Deployment of myapp to production failed!"
//     }
}