pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build') {
            steps {
                sh """
                    ./mvnw clean package -DskipTests
                """
            }
        }

        stage('Run App') {
            steps {
                sh """
                    # Run the new build
                    java -jar target/*.jar
                """
            }
        }
    }
}
