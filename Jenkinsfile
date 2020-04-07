pipeline {
   agent {
       docker {
           image 'python'
       }
   }

   stages {
      stage('Build') {
         steps {
            echo 'Compilando ou resolvendo as dependencias do projeto'
            sh 'pip install robotframework'
         }
      }
      stage('Tests') {
         steps {
            echo 'Executando testes de regrassão'
            sh 'robot -d ./log -e todo tests/'
         }
      }
      stage('UAT') {
         steps {
            echo 'Agurdando testes de aceitação do usuário.'
            input(message: 'Go to Production?', ok: 'Yes')
         }
      }
      stage('Production') {
         steps {
            echo 'App is Ready :)'
         }
      }
   }
}