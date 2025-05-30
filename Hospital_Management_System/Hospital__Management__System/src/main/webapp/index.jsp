<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hospital Management System</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">
    <style>
        :root {
            /* Professional Medical Color Palette */
            --primary-color: #0f4c75;
            --primary-light: #3282b8;
            --primary-dark: #0b3954;
            --secondary-color: #e8f4f8;
            --accent-color: #00a8cc;
            --success-color: #28a745;
            --warning-color: #ffc107;
            --danger-color: #dc3545;
            --info-color: #17a2b8;
            
            /* Neutral Colors */
            --white: #ffffff;
            --gray-50: #f8fafc;
            --gray-100: #f1f5f9;
            --gray-200: #e2e8f0;
            --gray-300: #cbd5e1;
            --gray-400: #94a3b8;
            --gray-500: #64748b;
            --gray-600: #475569;
            --gray-700: #334155;
            --gray-800: #1e293b;
            --gray-900: #0f172a;
            
            /* Text Colors */
            --text-primary: #1e293b;
            --text-secondary: #475569;
            --text-light: #64748b;
            --text-muted: #94a3b8;
            
            /* Background */
            --bg-primary: #f8fafc;
            --bg-secondary: #ffffff;
            --bg-accent: #e8f4f8;
            
            /* Shadows */
            --shadow-sm: 0 1px 2px 0 rgba(0, 0, 0, 0.05);
            --shadow-md: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06);
            --shadow-lg: 0 10px 15px -3px rgba(0, 0, 0, 0.1), 0 4px 6px -2px rgba(0, 0, 0, 0.05);
            --shadow-xl: 0 20px 25px -5px rgba(0, 0, 0, 0.1), 0 10px 10px -5px rgba(0, 0, 0, 0.04);
            
            /* Glass Effect */
            --glass-bg: rgba(255, 255, 255, 0.9);
            --glass-border: rgba(255, 255, 255, 0.18);
            
            /* Border Radius */
            --radius-sm: 6px;
            --radius-md: 8px;
            --radius-lg: 12px;
            --radius-xl: 16px;
            
            /* Transitions */
            --transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            --transition-fast: all 0.15s ease-out;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
            background: var(--bg-primary);
            color: var(--text-primary);
            line-height: 1.6;
            overflow-x: hidden;
            font-size: 14px;
        }

        /* Subtle background pattern */
        body::before {
            content: '';
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: 
                radial-gradient(circle at 25% 25%, rgba(15, 76, 117, 0.04) 0%, transparent 50%),
                radial-gradient(circle at 75% 75%, rgba(0, 168, 204, 0.03) 0%, transparent 50%);
            z-index: -1;
            pointer-events: none;
        }

        .container {
            max-width: 1400px;
            margin: 0 auto;
            padding: 0 24px;
        }

        /* Header */
        .header {
            background: var(--white);
            padding: 32px 0;
            box-shadow: var(--shadow-sm);
            border-bottom: 1px solid var(--gray-200);
            position: sticky;
            top: 0;
            z-index: 100;
        }

        .header-content {
            display: flex;
            align-items: center;
            gap: 20px;
        }

        .header-logo {
            display: flex;
            align-items: center;
            gap: 16px;
        }

        .header-icon {
            width: 56px;
            height: 56px;
            background: linear-gradient(135deg, var(--primary-color), var(--primary-light));
            border-radius: var(--radius-lg);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 24px;
            color: var(--white);
            box-shadow: var(--shadow-md);
        }

        .header-text h1 {
            font-family: 'Poppins', sans-serif;
            font-size: 28px;
            font-weight: 700;
            color: var(--primary-color);
            margin-bottom: 4px;
        }

        .header-text p {
            font-size: 15px;
            color: var(--text-secondary);
            font-weight: 500;
        }

        /* Message Box */
        .message-box {
            max-width: 600px;
            margin: 24px auto;
            padding: 16px 20px;
            background: linear-gradient(135deg, rgba(40, 167, 69, 0.1), rgba(40, 167, 69, 0.05));
            border: 1px solid rgba(40, 167, 69, 0.2);
            border-radius: var(--radius-md);
            color: var(--success-color);
            font-weight: 500;
            display: none;
            align-items: center;
            gap: 12px;
            animation: slideInDown 0.4s ease-out;
        }

        .message-box i {
            font-size: 18px;
        }

        /* Main Content */
        .main-content {
            padding: 48px 0;
        }

        .section-header {
            text-align: center;
            margin-bottom: 48px;
        }

        .section-header h2 {
            font-family: 'Poppins', sans-serif;
            font-size: 32px;
            font-weight: 700;
            color: var(--primary-color);
            margin-bottom: 12px;
        }

        .section-header p {
            font-size: 16px;
            color: var(--text-secondary);
            max-width: 600px;
            margin: 0 auto;
        }

        /* Card Grid - Always 5 cards in one row */
        .card-grid {
            display: grid;
            grid-template-columns: repeat(5, 1fr);
            gap: 24px;
            margin-bottom: 64px;
        }

        .card {
            background: var(--white);
            border: 1px solid var(--gray-200);
            border-radius: var(--radius-lg);
            padding: 28px 20px;
            text-align: center;
            text-decoration: none;
            color: var(--text-primary);
            transition: var(--transition);
            position: relative;
            overflow: hidden;
            box-shadow: var(--shadow-sm);
            min-height: 200px;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
        }

        .card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: linear-gradient(90deg, var(--primary-color), var(--accent-color));
            transform: scaleX(0);
            transform-origin: left;
            transition: var(--transition);
        }

        .card:hover::before {
            transform: scaleX(1);
        }

        .card:hover {
            transform: translateY(-4px);
            box-shadow: var(--shadow-lg);
            border-color: var(--primary-light);
        }

        .card-icon {
            width: 64px;
            height: 64px;
            margin: 0 auto 20px;
            background: linear-gradient(135deg, var(--bg-accent), var(--secondary-color));
            border-radius: var(--radius-lg);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 24px;
            color: var(--primary-color);
            transition: var(--transition);
            border: 2px solid var(--gray-200);
        }

        .card:hover .card-icon {
            background: linear-gradient(135deg, var(--primary-color), var(--primary-light));
            color: var(--white);
            border-color: var(--primary-color);
            transform: scale(1.05);
        }

        .card h3 {
            font-family: 'Poppins', sans-serif;
            font-size: 16px;
            font-weight: 600;
            margin-bottom: 8px;
            color: var(--text-primary);
            transition: var(--transition);
        }

        .card:hover h3 {
            color: var(--primary-color);
        }

        .card p {
            color: var(--text-secondary);
            font-size: 13px;
            line-height: 1.5;
        }

        /* Features Section */
        .features-section {
            background: var(--white);
            border-radius: var(--radius-xl);
            padding: 56px 48px;
            margin: 48px 0;
            border: 1px solid var(--gray-200);
            box-shadow: var(--shadow-md);
        }

        .features-header {
            text-align: center;
            margin-bottom: 48px;
        }

        .features-header h3 {
            font-family: 'Poppins', sans-serif;
            font-size: 28px;
            font-weight: 700;
            color: var(--primary-color);
            margin-bottom: 12px;
        }

        .features-header p {
            color: var(--text-secondary);
            font-size: 16px;
        }

        .features-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(320px, 1fr));
            gap: 40px;
        }

        .feature {
            text-align: center;
            padding: 32px 24px;
            border-radius: var(--radius-lg);
            transition: var(--transition);
            position: relative;
        }

        .feature:hover {
            background: var(--bg-accent);
            transform: translateY(-4px);
        }

        .feature-icon {
            width: 72px;
            height: 72px;
            margin: 0 auto 24px;
            background: linear-gradient(135deg, var(--bg-accent), var(--secondary-color));
            border-radius: var(--radius-lg);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 28px;
            color: var(--primary-color);
            transition: var(--transition);
            border: 2px solid var(--gray-200);
        }

        .feature:hover .feature-icon {
            background: linear-gradient(135deg, var(--primary-color), var(--accent-color));
            color: var(--white);
            border-color: var(--primary-color);
            transform: scale(1.1);
        }

        .feature h4 {
            font-family: 'Poppins', sans-serif;
            font-size: 20px;
            font-weight: 600;
            margin-bottom: 12px;
            color: var(--text-primary);
        }

        .feature p {
            color: var(--text-secondary);
            line-height: 1.6;
            font-size: 15px;
        }

        /* Stats Section */
        .stats-section {
            background: linear-gradient(135deg, var(--primary-color), var(--primary-light));
            border-radius: var(--radius-xl);
            padding: 48px;
            margin: 48px 0;
            color: var(--white);
        }

        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 32px;
            text-align: center;
        }

        .stat-item h4 {
            font-family: 'Poppins', sans-serif;
            font-size: 36px;
            font-weight: 700;
            margin-bottom: 8px;
        }

        .stat-item p {
            font-size: 16px;
            opacity: 0.9;
        }

        /* Footer */
        .footer {
            background: var(--white);
            text-align: center;
            padding: 32px 0;
            margin-top: 64px;
            border-top: 1px solid var(--gray-200);
            color: var(--text-secondary);
        }

        .footer p {
            font-size: 14px;
        }

        /* Animations */
        @keyframes slideInDown {
            from { opacity: 0; transform: translateY(-20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        @keyframes fadeInUp {
            from { opacity: 0; transform: translateY(30px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .card {
            animation: fadeInUp 0.6s ease-out;
        }

        .card:nth-child(1) { animation-delay: 0s; }
        .card:nth-child(2) { animation-delay: 0.1s; }
        .card:nth-child(3) { animation-delay: 0.2s; }
        .card:nth-child(4) { animation-delay: 0.3s; }
        .card:nth-child(5) { animation-delay: 0.4s; }

        /* Responsive Design */
        @media (max-width: 1200px) {
            .container {
                max-width: 1200px;
            }
            
            .card-grid {
                grid-template-columns: repeat(5, 1fr);
                gap: 20px;
            }
            
            .card {
                min-height: 180px;
                padding: 24px 16px;
            }
            
            .card h3 {
                font-size: 15px;
            }
            
            .card p {
                font-size: 12px;
            }
        }

        @media (max-width: 1024px) {
            .card-grid {
                grid-template-columns: repeat(3, 1fr);
                gap: 20px;
            }
            
            .features-section {
                padding: 40px 32px;
            }
        }

        @media (max-width: 768px) {
            .container {
                padding: 0 16px;
            }

            .header {
                padding: 24px 0;
            }

            .header-content {
                flex-direction: column;
                text-align: center;
                gap: 16px;
            }

            .header-text h1 {
                font-size: 24px;
            }

            .main-content {
                padding: 32px 0;
            }

            .card-grid {
                grid-template-columns: repeat(2, 1fr);
                gap: 16px;
            }

            .features-section {
                padding: 32px 20px;
            }

            .features-grid {
                grid-template-columns: 1fr;
                gap: 32px;
            }

            .stats-grid {
                grid-template-columns: repeat(2, 1fr);
                gap: 24px;
            }
        }

        @media (max-width: 480px) {
            .card-grid {
                grid-template-columns: 1fr;
            }
            
            .stats-grid {
                grid-template-columns: 1fr;
            }
        }

        /* Loading Animation */
        .loading {
            opacity: 0;
            animation: fadeIn 0.8s ease-out 0.3s forwards;
        }

        @keyframes fadeIn {
            to { opacity: 1; }
        }

        /* Utility classes */
        .text-center { text-align: center; }
        .mb-4 { margin-bottom: 16px; }
        .mt-4 { margin-top: 16px; }
    </style>
</head>
<body class="loading">
    <header class="header">
        <div class="container">
            <div class="header-content">
                <div class="header-logo">
                    <div class="header-icon">
                        <i class="fas fa-hospital-symbol"></i>
                    </div>
                    <div class="header-text">
                        <h1>Hospital Management System</h1>
                        <!-- <p>Advanced Healthcare Management System</p> -->
                    </div>
                </div>
            </div>
        </div>
    </header>

    <!-- Message Box -->
    <div class="container">
        <div class="message-box" id="messageBox">
            <i class="fas fa-check-circle"></i>
            <span id="messageText">Operation completed successfully!</span>
        </div>
    </div>

    <main class="main-content">
        <div class="container">
            <div class="section-header">
                <h2>Patient Management Dashboard</h2>
                <p>Comprehensive tools for managing patient records, appointments, and medical data with advanced security and efficiency</p>
            </div>

            <div class="card-grid">
                <a href="patientadd.jsp" class="card">
                    <div class="card-icon">
                        <i class="fas fa-user-plus"></i>
                    </div>
                    <h3>Add New Patient</h3>
                    <p>Register new patients and create comprehensive medical profiles</p>
                </a>

                <a href="UpdatePatientServlet" class="card">
                    <div class="card-icon">
                        <i class="fas fa-user-edit"></i>
                    </div>
                    <h3>Update Patient</h3>
                    <p>Modify and update existing patient records and medical information</p>
                </a>

                <a href="patientdelete.jsp" class="card">
                    <div class="card-icon">
                        <i class="fas fa-user-minus"></i>
                    </div>
                    <h3>Remove Patient</h3>
                    <p>Safely remove patient records from the hospital management system</p>
                </a>

                <a href="DisplayPatientsServlet" class="card">
                    <div class="card-icon">
                        <i class="fas fa-users"></i>
                    </div>
                    <h3>View All Patients</h3>
                    <p>Browse and search through all registered patient records</p>
                </a>

                <a href="report_form.jsp" class="card">
                    <div class="card-icon">
                        <i class="fas fa-file-medical-alt"></i>
                    </div>
                    <h3>Medical Reports</h3>
                    <p>Generate comprehensive medical reports and analytics</p>
                </a>
            </div>

            

            <div class="features-section">
                <div class="features-header">
                    <h3>Advanced Healthcare Features</h3>
                    <p>Comprehensive solutions designed to enhance patient care and streamline hospital operations</p>
                </div>
                
                <div class="features-grid">
                    <div class="feature">
                        <div class="feature-icon">
                            <i class="fas fa-calendar-check"></i>
                        </div>
                        <h4>Smart Scheduling</h4>
                        <p>AI-powered appointment scheduling with automated reminders, conflict detection, and optimal resource allocation for enhanced patient experience.</p>
                    </div>

                    <div class="feature">
                        <div class="feature-icon">
                            <i class="fas fa-user-md"></i>
                        </div>
                        <h4>Staff Management</h4>
                        <p>Complete healthcare professional management including credentials, schedules, specializations, and performance tracking systems.</p>
                    </div>

                    <div class="feature">
                        <div class="feature-icon">
                            <i class="fas fa-chart-line"></i>
                        </div>
                        <h4>Analytics & Insights</h4>
                        <p>Advanced reporting and data analytics to support evidence-based decision making and continuous improvement in patient care quality.</p>
                    </div>
                </div>
            </div>
        </div>
    </main>

    <footer class="footer">
        <div class="container">
            <p>&copy; 2025 Hospital Management System | Developed by Shivani Kamath</p>
        </div>
    </footer>

    <script>
        // Simulate JSP message functionality
        function showMessage(text, type = 'success') {
            const messageBox = document.getElementById('messageBox');
            const messageText = document.getElementById('messageText');
            messageText.textContent = text;
            messageBox.style.display = 'flex';
            
            // Auto hide after 5 seconds
            setTimeout(() => {
                messageBox.style.display = 'none';
            }, 5000);
        }

        // Add smooth scroll behavior
        document.querySelectorAll('a[href^="#"]').forEach(anchor => {
            anchor.addEventListener('click', function (e) {
                e.preventDefault();
                const target = document.querySelector(this.getAttribute('href'));
                if (target) {
                    target.scrollIntoView({
                        behavior: 'smooth',
                        block: 'start'
                    });
                }
            });
        });

        // Add loading animation
        window.addEventListener('load', () => {
            document.body.classList.remove('loading');
        });

        // Add card interaction effects
        document.querySelectorAll('.card').forEach(card => {
            card.addEventListener('mouseenter', function() {
                this.style.transform = 'translateY(-4px) scale(1.02)';
            });
            
            card.addEventListener('mouseleave', function() {
                this.style.transform = 'translateY(0) scale(1)';
            });
            
            card.addEventListener('click', function(e) {
                // Add ripple effect
                const ripple = document.createElement('div');
                const rect = this.getBoundingClientRect();
                const size = Math.max(rect.width, rect.height);
                const x = e.clientX - rect.left - size / 2;
                const y = e.clientY - rect.top - size / 2;
                
                ripple.style.cssText = `
                    position: absolute;
                    width: ${size}px;
                    height: ${size}px;
                    left: ${x}px;
                    top: ${y}px;
                    background: rgba(15, 76, 117, 0.1);
                    border-radius: 50%;
                    transform: scale(0);
                    animation: ripple 0.6s linear;
                    pointer-events: none;
                `;
                
                this.appendChild(ripple);
                setTimeout(() => ripple.remove(), 600);
            });
        });

        // Add CSS for ripple effect
        const style = document.createElement('style');
        style.textContent = `
            @keyframes ripple {
                to {
                    transform: scale(4);
                    opacity: 0;
                }
            }
            
            .card {
                position: relative;
                overflow: hidden;
            }
        `;
        document.head.appendChild(style);

        // Add intersection observer for scroll animations
        const observerOptions = {
            threshold: 0.1,
            rootMargin: '0px 0px -50px 0px'
        };

        const observer = new IntersectionObserver((entries) => {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    entry.target.style.opacity = '1';
                    entry.target.style.transform = 'translateY(0)';
                }
            });
        }, observerOptions);

        // Observe elements for scroll animations
        document.querySelectorAll('.feature, .stat-item').forEach(el => {
            el.style.opacity = '0';
            el.style.transform = 'translateY(30px)';
            el.style.transition = 'all 0.6s ease-out';
            observer.observe(el);
        });
    </script>
</body>
</html>