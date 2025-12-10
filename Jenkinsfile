pipeline {
  agent any

  environment {
    FLUTTER_VERSION = '3.38.4'
    FLUTTER_DIR = "${env.WORKSPACE}/flutter_sdk"
    PATH = "${env.PATH}:${env.WORKSPACE}/flutter_sdk/bin"
  }

  stages {
    stage('Checkout') {
      steps {
        checkout scm
      }
    }

    stage('Install Flutter') {
      steps {
        sh '''
          if [ ! -d "${FLUTTER_DIR}" ]; then
            git clone https://github.com/flutter/flutter.git -b 3.38.4 ${FLUTTER_DIR}
          fi
          export PATH="$PATH:${FLUTTER_DIR}/bin"
          flutter --version
        '''
      }
    }

    stage('Dependencies') {
      steps {
        sh '''
          flutter pub get
        '''
      }
    }

    stage('Unit Tests') {
      steps {
        sh '''
          flutter test --coverage
        '''
      }
    }
  }
}
