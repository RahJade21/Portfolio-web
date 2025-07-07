<?php

// Add this at the VERY TOP of portfolio_api.php
error_reporting(0); // Turn off error display
ini_set('display_errors', 0); // Prevent HTML error output
ini_set('log_errors', 1); // Log errors instead

// Set content type first
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type');

// Handle preflight requests
if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit();
}

// Catch any PHP errors and return JSON
register_shutdown_function(function() {
    $error = error_get_last();
    if ($error && $error['type'] === E_ERROR) {
        http_response_code(500);
        echo json_encode(['error' => 'Internal server error']);
    }
});

// Rate limiting (simple implementation)
function checkRateLimit($email) {
    $rateLimitFile = 'tmp/rate_limit.json';
    $currentTime = time();
    $rateLimit = 5; // Max 5 submissions per hour
    $timeWindow = 3600; // 1 hour
    
    // Create tmp directory if it doesn't exist
    if (!file_exists('tmp/')) {
        mkdir('tmp/', 0777, true);
    }
    
    // Load existing rate limit data
    if (file_exists($rateLimitFile)) {
        $rateLimitData = json_decode(file_get_contents($rateLimitFile), true);
    } else {
        $rateLimitData = [];
    }
    
    // Clean old entries
    foreach ($rateLimitData as $key => $data) {
        if ($currentTime - $data['timestamp'] > $timeWindow) {
            unset($rateLimitData[$key]);
        }
    }
    
    // Check current email submissions
    $emailSubmissions = array_filter($rateLimitData, function($data) use ($email) {
        return $data['email'] === $email;
    });
    
    if (count($emailSubmissions) >= $rateLimit) {
        return false;
    }
    
    // Add current submission
    $rateLimitData[] = [
        'email' => $email,
        'timestamp' => $currentTime
    ];
    
    // Save updated data
    file_put_contents($rateLimitFile, json_encode($rateLimitData));
    
    return true;
}

// Spam detection
function detectSpam($message, $subject, $name) {
    $spamKeywords = ['viagra', 'casino', 'lottery', 'winner', 'congratulations', 'claim now', 'act now'];
    $text = strtolower($message . ' ' . $subject . ' ' . $name);
    
    foreach ($spamKeywords as $keyword) {
        if (strpos($text, $keyword) !== false) {
            return true;
        }
    }
    
    // Check for excessive links
    $linkCount = preg_match_all('/https?:\/\//', $message);
    if ($linkCount > 2) {
        return true;
    }
    
    return false;
}

// Input length validation
function validateInputLengths($input) {
    $limits = [
        'name' => 100,
        'subject' => 200,
        'message' => 2000
    ];
    
    foreach ($limits as $field => $limit) {
        if (strlen($input[$field]) > $limit) {
            return false;
        }
    }
    
    return true;
}

// Updated require path for new folder structure
require_once '../config/database.php';

// Email configuration
define('CONTACT_EMAIL', 'jayadeva2121@gmail.com'); // Your email
define('SITE_NAME', 'Jaya Deva Portfolio');
// Configure mail settings for your server
ini_set('sendmail_from', CONTACT_EMAIL);
ini_set('SMTP', 'smtp.gmail.com'); // Change to your hosting provider's SMTP
ini_set('smtp_port', '587');

$database = new Database();
$action = $_GET['action'] ?? '';

switch ($action) {
    case 'projects':
        getProjects($database);
        break;
    case 'competencies':
        getCompetencies($database);
        break;
    case 'education_experience':
        getEducationExperience($database);
        break;
    case 'skills':
        getSkills($database);
        break;
    case 'about':
        getAboutLinks($database);
        break;
    case 'contact':
        if ($_SERVER['REQUEST_METHOD'] === 'POST') {
            submitContact($database);
        } else {
            http_response_code(405);
            echo json_encode(['error' => 'Method not allowed']);
        }
        break;
    default:
        http_response_code(404);
        echo json_encode(['error' => 'Endpoint not found']);
        break;
}

function getProjects($database) {
    try {
        $database->query('SELECT count, label FROM projects ORDER BY id');
        $projects = $database->resultset();
        echo json_encode($projects);
    } catch (Exception $e) {
        http_response_code(500);
        echo json_encode(['error' => 'Failed to fetch projects']);
    }
}

function getCompetencies($database) {
    try {
        $database->query('SELECT img, alt, title, description as `desc` FROM competencies ORDER BY id');
        $competencies = $database->resultset();
        echo json_encode($competencies);
    } catch (Exception $e) {
        http_response_code(500);
        echo json_encode(['error' => 'Failed to fetch competencies']);
    }
}

function getEducationExperience($database) {
    try {
        // Changed ORDER BY to DESC to get latest first
        $database->query('SELECT image_path AS img, title, description AS `desc` FROM education ORDER BY id DESC');
        $education = $database->resultset();
        
        // Changed ORDER BY to DESC to get latest first
        $database->query('SELECT id, title, `date_range` AS date FROM experience ORDER BY id DESC');
        $experiences = $database->resultset();
        
        foreach ($experiences as &$experience) {
            $database->query('SELECT detail FROM experience_details WHERE experience_id = :exp_id ORDER BY id');
            $database->bind(':exp_id', $experience['id']);
            $details = $database->resultset();
            $experience['details'] = array_column($details, 'detail');
            unset($experience['id']);
        }
        
        $result = [
            'education' => $education,
            'experience' => $experiences
        ];
        
        echo json_encode($result, JSON_UNESCAPED_SLASHES);
    } catch (Exception $e) {
        http_response_code(500);
        echo json_encode(['error' => 'Failed to fetch education/experience data: ' . $e->getMessage()]);
    }
}

function getSkills($database) {
    try {
        $database->query('SELECT logo_path AS logo, alt, category FROM skills ORDER BY id');
        $skills = $database->resultset();
        echo json_encode($skills, JSON_UNESCAPED_SLASHES);
    } catch (Exception $e) {
        http_response_code(500);
        echo json_encode(['error' => 'Failed to fetch skills: ' . $e->getMessage()]);
    }
}

function getAboutLinks($database) {
    try {
        $database->query('SELECT url, logo_path as logo, platform as alt FROM social_media ORDER BY id');
        $about = $database->resultset();
        echo json_encode($about);
    } catch (Exception $e) {
        http_response_code(500);
        echo json_encode(['error' => 'Failed to fetch about links']);
    }
}

// Updated submitContact function
function submitContact($database) {
    try {
        $input = json_decode(file_get_contents('php://input'), true);
        
        // Validate required fields
        if (!isset($input['name']) || !isset($input['email']) || !isset($input['subject']) || !isset($input['message'])) {
            http_response_code(400);
            echo json_encode(['error' => 'All fields are required']);
            return;
        }

        // Validate email
        if (!filter_var($input['email'], FILTER_VALIDATE_EMAIL)) {
            http_response_code(400);
            echo json_encode(['error' => 'Invalid email format']);
            return;
        }

        // Check rate limit
        if (!checkRateLimit($input['email'])) {
            http_response_code(429);
            echo json_encode(['error' => 'Too many submissions. Please try again later.']);
            return;
        }

        // Validate input lengths
        if (!validateInputLengths($input)) {
            http_response_code(400);
            echo json_encode(['error' => 'Input too long']);
            return;
        }

        // Sanitize input
        $name = htmlspecialchars(trim($input['name']));
        $email = htmlspecialchars(trim($input['email']));
        $subject = htmlspecialchars(trim($input['subject']));
        $message = htmlspecialchars(trim($input['message']));

        // Spam detection
        if (detectSpam($message, $subject, $name)) {
            http_response_code(400);
            echo json_encode(['error' => 'Message flagged as spam']);
            return;
        }

        // Save to database (assuming you have a contacts table)
        $database->query('INSERT INTO contacts (name, email, subject, message, created_at) VALUES (:name, :email, :subject, :message, NOW())');
        $database->bind(':name', $name);
        $database->bind(':email', $email);
        $database->bind(':subject', $subject);
        $database->bind(':message', $message);
        
        if ($database->execute()) {
            // Send email notification
            if (sendContactEmail($name, $email, $subject, $message)) {
                echo json_encode(['success' => true, 'message' => 'Message sent successfully']);
            } else {
                // Even if email fails, the message was saved
                echo json_encode(['success' => true, 'message' => 'Message saved successfully, but email notification failed']);
            }
        } else {
            throw new Exception('Database insert failed');
        }
        
    } catch (Exception $e) {
        error_log("Contact form error: " . $e->getMessage());
        http_response_code(500);
        echo json_encode(['error' => 'Server error. Please try again later.']);
    }
}

function sendContactEmail($name, $email, $subject, $message) {
    if ($_SERVER['REQUEST_METHOD'] === 'POST' && $_GET['action'] === 'contact') {
        require_once __DIR__ . '/../config/mail_config.php';

        $data = json_decode(file_get_contents("php://input"), true);
        $name = $data['name'] ?? '';
        $email = $data['email'] ?? '';
        $subject = $data['subject'] ?? '';
        $message = $data['message'] ?? '';

        if (!$name || !$email || !$subject || !$message) {
            http_response_code(400);
            echo json_encode(['error' => 'Incomplete data']);
            exit;
        }

        try {
            $mail = getMailer();
            $mail->addAddress($_ENV['MAIL_USERNAME'], $_ENV['MAIL_FROM_NAME']);
            $mail->isHTML(true);
            $mail->Subject = "Portfolio Contact: $subject";
            $mail->Body    = "
                <h3>New Contact Message</h3>
                <p><strong>Name:</strong> $name</p>
                <p><strong>Email:</strong> $email</p>
                <p><strong>Message:</strong><br>$message</p>
            ";
            $mail->send();

            echo json_encode(['success' => true]);
        } catch (Exception $e) {
            http_response_code(500);
            echo json_encode(['error' => 'Message could not be sent. Mailer Error: ' . $mail->ErrorInfo]);
        }
        exit;
    }
}
?>