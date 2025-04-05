pipeline {
    agent any

    environment {
        // Define environment variables for Docker and SonarQube
        DOCKER_CREDENTIALS_ID = 'Silmi3607'  // Set your DockerHub credentials ID
        DOCKER_IMAGE = 'Silmi3607/devsecops-app'  // Define your Docker image name
        SONARQUBE_PROJECT_KEY = 'devsecops-project'  // Your SonarQube project key
        SONARQUBE_URL = 'http://localhost:8081'  // Update with your SonarQube URL if different
        SONARQUBE_AUTH_TOKEN = 'squ_170f8ec3ec0dc20c1dcbfa5649c7a99453ba965a'  // Replace with your actual SonarQube token
    }

    stages {
        stage('Checkout') {
            steps {
                // Checkout code from the repository
                git 'https://github.com/Silmi3607/Assignment3.git'  // Replace with your repo URL
            }
        }

        stage('Build') {
            steps {
                // Build your project with Maven
                sh 'mvn clean package'
            }
        }

        stage('Test') {
            steps {
                // Run unit tests and output the results to a file
                sh 'mvn test > unit-test-report.txt'
            }
        }

        stage('SonarQube Analysis') {
            steps {
                script {
                    // Run SonarQube analysis
                    withSonarQubeEnv('SonarQube') {
                        sh """
                            mvn sonar:sonar \
                                -Dsonar.projectKey=${SONARQUBE_PROJECT_KEY} \
                                -Dsonar.host.url=${SONARQUBE_URL} \
                                -Dsonar.login=${SONARQUBE_AUTH_TOKEN}
                        """
                    }
                }
            }
        }

        stage('Dependency Check') {
            steps {
                // Run Dependency-Check for vulnerabilities
                sh './dependency-check.sh'
            }
        }

        stage('Docker Build and Push') {
            steps {
                script {
                    // Build and push Docker image to DockerHub
                    docker.withRegistry('', "${DOCKER_CREDENTIALS_ID}") {
                        def customImage = docker.build("${DOCKER_IMAGE}")
                        customImage.push()
                    }
                }
            }
        }

        stage('Send Email') {
            steps {
                // Send the email with reports (modify with your script path if needed)
                sh './send_report_email.sh'
            }
        }
    }

    post {
        always {
            // Actions that always run, like cleaning up or notifications
            echo 'Cleaning up...'
        }
        success {
            // Actions to perform when the pipeline succeeds
            echo 'Pipeline succeeded!'
        }
        failure {
            // Actions to perform when the pipeline fails
            echo 'Pipeline failed!'
        }
    }
}
