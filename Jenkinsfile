pipeline {
    agent any

    environment {
        FLUTTER_BIN = "C:\\src\\flutter\\bin\\flutter"
        PATH = "${env.PATH};C:\\src\\flutter\\bin"
    }

    stages {

        stage('Checkout') {
            steps {
                echo "Cloning repository..."
                checkout scm
            }
        }

        stage('Flutter Doctor') {
            steps {
                echo "Checking Flutter SDK..."
                bat '"%FLUTTER_BIN%" doctor -v'
            }
        }

        stage('Dependencies') {
            steps {
                echo "Running flutter pub get..."
                bat '"%FLUTTER_BIN%" pub get --offline --no-precompile'
            }
        }

        stage('Run Unit Tests') {
            steps {
                echo "Running unit tests with coverage..."
                bat '"%FLUTTER_BIN%" test --coverage --machine'
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
