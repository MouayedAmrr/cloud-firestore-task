pipeline {
    agent any

    environment {
        FLUTTER_DIR = "${env.WORKSPACE}\\flutter_sdk"
        PATH = "${env.PATH};${env.WORKSPACE}\\flutter_sdk\\bin"
    }

    stages {

        stage('Checkout') {
            steps {
                echo "Cloning repository..."
                checkout scm
            }
        }

        stage('Install Flutter') {
            steps {
                echo "Checking Flutter SDK..."
                bat '''
                if not exist "%FLUTTER_DIR%" (
                    git clone https://github.com/flutter/flutter.git -b 3.38.4 "%FLUTTER_DIR%"
                )
                echo Flutter SDK path: %FLUTTER_DIR%
                %FLUTTER_DIR%\\bin\\flutter --version
                '''
            }
        }

        stage('Dependencies') {
            steps {
                echo "Running flutter pub get..."
                bat '%FLUTTER_DIR%\\bin\\flutter pub get'
            }
        }

        stage('Run Unit Tests') {
            steps {
                echo "Running unit tests with coverage..."
                bat '%FLUTTER_DIR%\\bin\\flutter test --coverage'
            }
        }

    }

    post {
        always {
            echo "Build finished!"
        }
        success {
            echo "Tests passed successfully!"
        }
        failure {
            echo "Tests failed. Check console output."
        }
    }
}
