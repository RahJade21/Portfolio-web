
<?php
// Create a simple test file: test_db.php
header('Content-Type: application/json');

try {
    require_once 'config/database.php';
    $database = new Database();
    
    // Test a simple query
    $database->query('SELECT 1 as test');
    $result = $database->single();
    
    echo json_encode([
        'success' => true, 
        'message' => 'Database connection successful',
        'test_result' => $result
    ]);
    
} catch (Exception $e) {
    http_response_code(500);
    echo json_encode([
        'success' => false,
        'error' => $e->getMessage()
    ]);
}
?>