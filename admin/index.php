<?php
session_start();
if (!isset($_SESSION['admin_logged_in'])) {
    header('Location: login.php');
    exit;
}

require_once '../config/database.php';

$database = new Database();

// Handle form submissions
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $action = $_POST['action'] ?? '';
    
    switch ($action) {
        case 'add_project':
            $database->query('INSERT INTO projects (count, label) VALUES (:count, :label)');
            $database->bind(':count', $_POST['count']);
            $database->bind(':label', $_POST['label']);
            $database->execute();
            break;
            
        case 'edit_project':
            $database->query('UPDATE projects SET count = :count, label = :label WHERE id = :id');
            $database->bind(':count', $_POST['count']);
            $database->bind(':label', $_POST['label']);
            $database->bind(':id', $_POST['id']);
            $database->execute();
            break;

        case 'delete_project':
            $database->query('DELETE FROM projects WHERE id = :id');
            $database->bind(':id', $_POST['id']);
            $database->execute();
            break;

        case 'add_competency':
            $database->query('INSERT INTO competencies (title, description, img, alt) VALUES (:title, :description, :img, :alt)');
            $database->bind(':title', $_POST['title']);
            $database->bind(':description', $_POST['description']);
            $database->bind(':img', $_POST['img']);
            $database->bind(':alt', $_POST['alt']);
            $database->execute();
            break;

        case 'edit_competency':
            $database->query('UPDATE competencies SET title = :title, description = :description, img = :img, alt = :alt WHERE id = :id');
            $database->bind(':title', $_POST['title']);
            $database->bind(':description', $_POST['description']);
            $database->bind(':img', $_POST['img']);
            $database->bind(':alt', $_POST['alt']);
            $database->bind(':id', $_POST['id']);
            $database->execute();
            break;
        
        case 'delete_competency':
            $database->query('DELETE FROM competencies WHERE id = :id');
            $database->bind(':id', $_POST['id']);
            $database->execute();
            break;

        case 'add_education':
            $database->query('INSERT INTO education (title, description, image_path) VALUES (:title, :description, :image_path)');
            $database->bind(':title', $_POST['title']);
            $database->bind(':description', $_POST['description']);
            $database->bind(':image_path', $_POST['img']);
            $database->execute();
            break;

        case 'edit_education':
            $database->query('UPDATE education SET title = :title, description = :description, image_path = :image_path WHERE id = :id');
            $database->bind(':title', $_POST['title']);
            $database->bind(':description', $_POST['description']);
            $database->bind(':image_path', $_POST['img']);
            $database->bind(':id', $_POST['id']);
            $database->execute();
            break;

        case 'delete_education':
            $database->query('DELETE FROM education WHERE id = :id');
            $database->bind(':id', $_POST['id']);
            $database->execute();
            break;

        case 'add_experience':
            $database->query('INSERT INTO experience (title, date_range) VALUES (:title, :date_range)');
            $database->bind(':title', $_POST['title']);
            $database->bind(':date_range', $_POST['date_range']);
            $database->execute();
            $experienceId = $database->lastInsertId();

            $details = explode("\n", trim($_POST['details']));
            foreach ($details as $detail) {
                $database->query('INSERT INTO experience_details (experience_id, detail) VALUES (:experience_id, :detail)');
                $database->bind(':experience_id', $experienceId);
                $database->bind(':detail', trim($detail));
                $database->execute();
            }
            break;

        case 'edit_experience':
            $database->query('UPDATE experience SET title = :title, date_range = :date_range WHERE id = :id');
            $database->bind(':title', $_POST['title']);
            $database->bind(':date_range', $_POST['date_range']);
            $database->bind(':id', $_POST['id']);
            $database->execute();

            $database->query('DELETE FROM experience_details WHERE experience_id = :id');
            $database->bind(':id', $_POST['id']);
            $database->execute();

            $details = explode("\n", trim($_POST['details']));
            foreach ($details as $detail) {
                $database->query('INSERT INTO experience_details (experience_id, detail) VALUES (:experience_id, :detail)');
                $database->bind(':experience_id', $_POST['id']);
                $database->bind(':detail', trim($detail));
                $database->execute();
            }
            break;

        case 'delete_experience':
            $database->query('DELETE FROM experience WHERE id = :id');
            $database->bind(':id', $_POST['id']);
            $database->execute();
            break;

        case 'add_skill':
            $database->query('INSERT INTO skills (logo_path, alt, category) VALUES (:logo_path, :alt, :category)');
            $database->bind(':logo_path', $_POST['logo']);
            $database->bind(':alt', $_POST['alt']);
            $database->bind(':category', $_POST['category']);
            $database->execute();
            break;
            
        case 'edit_skill':
            $database->query('UPDATE skills SET logo_path = :logo_path, alt = :alt, category = :category WHERE id = :id');
            $database->bind(':logo_path', $_POST['logo']);
            $database->bind(':alt', $_POST['alt']);
            $database->bind(':category', $_POST['category']);
            $database->bind(':id', $_POST['id']);
            $database->execute();
            break;
            
        case 'delete_skill':
            $database->query('DELETE FROM skills WHERE id = :id');
            $database->bind(':id', $_POST['id']);
            $database->execute();
            break;

        case 'toggle_read_status':
            $messageId = $_POST['message_id'];
            $database->query('UPDATE contacts SET status = 1 WHERE id = :id');
            $database->bind(':id', $messageId);
            $database->execute();
            break;
            
        case 'delete_message':
            $database->query('DELETE FROM contacts WHERE id = :id');
            $database->bind(':id', $_POST['id']);
            $database->execute();
            break;
        }
    }

// Get data for display
$database->query('SELECT * FROM projects ORDER BY id');
$projects = $database->resultset();

$database->query('SELECT * FROM competencies ORDER BY id');
$competencies = $database->resultset();

$database->query('SELECT * FROM education ORDER BY id');
$educationList = $database->resultset();

// Fetch experience list
$database->query('SELECT * FROM experience ORDER BY id');
$experienceList = $database->resultset();
// Fetch related experience details
$database->query('SELECT * FROM experience_details ORDER BY experience_id, id');
$experienceDetailsRaw = $database->resultset();
$experienceDetailsMap = [];
foreach ($experienceDetailsRaw as $detail) {
    $experienceDetailsMap[$detail['experience_id']][] = $detail['detail'];
}

$database->query('SELECT * FROM skills ORDER BY id');
$skills = $database->resultset();

$database->query('SELECT * FROM contacts ORDER BY created_at DESC');
$messages = $database->resultset();
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Portfolio Admin Panel</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-700">
    <div class="container mx-auto p-8">
        <h1 class="text-3xl text-white font-bold mb-8">Portfolio Admin Panel</h1>
        
        <!-- Projects Section -->
        <div class="bg-gray-800 p-6 rounded-lg shadow-md mb-8 text-white">
            <h2 class="text-2xl font-bold mb-4">Projects</h2>
            
            <!-- Add Project Form -->
            <form method="POST" class="mb-6">
                <input type="hidden" name="action" value="add_project">
                <div class="grid grid-cols-2 gap-4">
                    <input type="text" name="count" placeholder="Count (e.g., 15+)" required 
                           class="bg-gray-700 text-white border border-gray-600 p-2 rounded focus:outline-none focus:ring-2 focus:ring-yellow-400">
                    <input type="text" name="label" placeholder="Label" required 
                           class="bg-gray-700 text-white border border-gray-600 p-2 rounded focus:outline-none focus:ring-2 focus:ring-yellow-400">
                </div>
                <button type="submit" class="mt-2 bg-blue-500 text-white px-4 py-2 rounded hover:bg-blue-600">
                    Add Project
                </button>
            </form>

            <!-- Edit Project Form (Hidden by default) -->
            <div id="editProjectForm" class="hidden mb-6 p-4 border-2 border-red-400 rounded bg-red-100">
                <h3 class="text-lg font-bold mb-2 text-black">Edit Project</h3>
                <form method="POST">
                    <input type="hidden" name="action" value="edit_project">
                    <input type="hidden" id="editProjectId" name="id">
                    <div class="grid grid-cols-2 gap-4">
                        <input type="text" id="editProjectCount" name="count" placeholder="Count (e.g., 15+)" required 
                            class="bg-gray-700 text-white border border-gray-600 p-2 rounded focus:outline-none focus:ring-2 focus:ring-yellow-400">
                        <input type="text" id="editProjectLabel" name="label" placeholder="Label" required 
                            class="bg-gray-700 text-white border border-gray-600 p-2 rounded focus:outline-none focus:ring-2 focus:ring-yellow-400">
                    </div>
                    <div class="mt-2">
                        <button type="submit" class="bg-green-500 text-white px-4 py-2 rounded hover:bg-green-600">
                            Update Project
                        </button>
                        <button type="button" onclick="cancelEdit('editProjectForm')" 
                                class="ml-2 bg-gray-500 text-white px-4 py-2 rounded hover:bg-gray-600">
                            Cancel
                        </button>
                    </div>
                </form>
            </div>
            
            <!-- Projects List -->
            <div class="overflow-x-auto">
                <table class="w-full border-collapse border">
                    <thead>
                        <tr class="bg-gray-700 text-white">
                            <th class="border p-2">ID</th>
                            <th class="border p-2">Count</th>
                            <th class="border p-2">Label</th>
                            <th class="border p-2">Created</th>
                            <th class="border p-2">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <?php foreach ($projects as $project): ?>
                        <tr class="text-white">
                            <td class="border p-2"><?php echo $project['id']; ?></td>
                            <td class="border p-2"><?php echo htmlspecialchars($project['count']); ?></td>
                            <td class="border p-2"><?php echo htmlspecialchars($project['label']); ?></td>
                            <td class="border p-2"><?php echo $project['created_at']; ?></td>
                            <td class="border p-2">
                                <button onclick="editProject(<?php echo $project['id']; ?>, '<?php echo htmlspecialchars($project['count']); ?>', '<?php echo htmlspecialchars($project['label']); ?>')" 
                                        class="bg-yellow-500 text-white px-2 py-1 rounded text-xs hover:bg-yellow-600 mr-1">
                                    Edit
                                </button>
                                <form method="POST" class="inline-block">
                                    <input type="hidden" name="action" value="delete_project">
                                    <input type="hidden" name="id" value="<?php echo $project['id']; ?>">
                                    <button type="submit" onclick="return confirm('Are you sure you want to delete this project?')" 
                                            class="bg-red-500 text-white px-2 py-1 rounded text-xs hover:bg-red-600">
                                        Delete
                                    </button>
                                </form>
                            </td>
                        </tr>
                        <?php endforeach; ?>
                    </tbody>
                </table>
            </div>
        </div>


        <!-- Competencies Section -->
        <div class="bg-gray-800 p-6 rounded-lg shadow-md mb-8 text-white">
            <h2 class="text-2xl font-bold mb-4">Competencies</h2>
            
            <!-- Add Competency Form -->
            <form method="POST" class="mb-6">
                <input type="hidden" name="action" value="add_competency">
                <div class="grid grid-cols-2 gap-4">
                    <input type="text" name="title" placeholder="Title" required class="bg-gray-700 text-white border border-gray-600 p-2 rounded focus:outline-none focus:ring-2 focus:ring-yellow-400">
                    <input type="text" name="description" placeholder="Description" required class="bg-gray-700 text-white border border-gray-600 p-2 rounded focus:outline-none focus:ring-2 focus:ring-yellow-400">
                    <input type="text" name="img" placeholder="Image path" required class="bg-gray-700 text-white border border-gray-600 p-2 rounded focus:outline-none focus:ring-2 focus:ring-yellow-400">
                    <input type="text" name="alt" placeholder="Alt" required class="bg-gray-700 text-white border border-gray-600 p-2 rounded focus:outline-none focus:ring-2 focus:ring-yellow-400">
                </div>
                <button type="submit" class="mt-2 bg-blue-500 text-white px-4 py-2 rounded hover:bg-blue-600">
                    Add Competency
                </button>
            </form>

            <!-- Edit Competency Form (Hidden by default) -->
            <div id="editCompetencyForm" class="hidden mb-6 p-4 border-2 border-red-400 rounded bg-red-100">
                <h3 class="text-lg font-bold mb-2 text-black">Edit Competency</h3>
                <form method="POST">
                    <input type="hidden" name="action" value="edit_competency">
                    <input type="hidden" id="editCompetencyId" name="id">
                    <div class="grid grid-cols-2 gap-4">
                        <input type="text" id="editCompetencyTitle" name="title" placeholder="Title" required class="bg-gray-700 text-white border border-gray-600 p-2 rounded focus:outline-none focus:ring-2 focus:ring-yellow-400">
                        <input type="text" id="editCompetencyDescription" name="description" placeholder="Description" required class="bg-gray-700 text-white border border-gray-600 p-2 rounded focus:outline-none focus:ring-2 focus:ring-yellow-400">
                        <input type="text" id="editCompetencyImg" name="img" placeholder="Image path" required class="bg-gray-700 text-white border border-gray-600 p-2 rounded focus:outline-none focus:ring-2 focus:ring-yellow-400">
                        <input type="text" id="editCompetencyAlt" name="alt" placeholder="Alt" required class="bg-gray-700 text-white border border-gray-600 p-2 rounded focus:outline-none focus:ring-2 focus:ring-yellow-400">
                    </div>
                    <div class="mt-2">
                        <button type="submit" class="bg-green-500 text-white px-4 py-2 rounded hover:bg-green-600">
                            Update Competency
                        </button>
                        <button type="button" onclick="cancelEdit('editCompetencyForm')" 
                                class="ml-2 bg-gray-500 text-white px-4 py-2 rounded hover:bg-gray-600">
                            Cancel
                        </button>
                    </div>
                </form>
            </div>
            
            <!-- Competency List -->
            <div class="overflow-x-auto">
                <table class="w-full border-collapse border">
                    <thead>
                        <tr class="bg-gray-700 text-white">
                            <th class="border p-2">ID</th>
                            <th class="border p-2">Title</th>
                            <th class="border p-2">Description</th>
                            <th class="border p-2">Image_path</th>
                            <th class="border p-2">Alt</th>
                            <th class="border p-2">Created</th>
                            <th class="border p-2">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <?php foreach ($competencies as $competency): ?>
                        <tr class="text-white">
                            <td class="border p-2"><?php echo $competency['id']; ?></td>
                            <td class="border p-2"><?php echo htmlspecialchars($competency['title']); ?></td>
                            <td class="border p-2"><?php echo htmlspecialchars($competency['description']); ?></td>
                            <td class="border p-2"><?php echo htmlspecialchars($competency['img']); ?></td>
                            <td class="border p-2"><?php echo htmlspecialchars($competency['alt']); ?></td>
                            <td class="border p-2"><?php echo $competency['created_at']; ?></td>
                            <td class="border p-2">
                                <button onclick="editCompetency(<?php echo $competency['id']; ?>, '<?php echo htmlspecialchars($competency['title']); ?>', '<?php echo htmlspecialchars($competency['description']); ?>', '<?php echo htmlspecialchars($competency['img']); ?>', '<?php echo htmlspecialchars($competency['alt']); ?>')"
                                        class="bg-yellow-500 text-white px-2 py-1 rounded text-xs hover:bg-yellow-600 mr-1">
                                    Edit
                                </button>
                                <form method="POST" class="inline-block">
                                    <input type="hidden" name="action" value="delete_competency">
                                    <input type="hidden" name="id" value="<?php echo $competency['id']; ?>">
                                    <button type="submit" onclick="return confirm('Are you sure you want to delete this competency?')" 
                                            class="bg-red-500 text-white px-2 py-1 rounded text-xs hover:bg-red-600">
                                        Delete
                                    </button>
                                </form>
                            </td>
                        </tr>
                        <?php endforeach; ?>
                    </tbody>
                </table>
            </div>
        </div>


        <!-- Skills Section -->
        <div class="bg-gray-800 p-6 rounded-lg shadow-md mb-8 text-white">
            <h2 class="text-2xl font-bold mb-4">Skills</h2>
            
            <!-- Add Skill Form -->
            <form method="POST" class="mb-6">
                <input type="hidden" name="action" value="add_skill">
                <div class="grid grid-cols-3 gap-4">
                    <input type="text" name="logo" placeholder="Logo path" required 
                           class="bg-gray-700 text-white border border-gray-600 p-2 rounded focus:outline-none focus:ring-2 focus:ring-yellow-400">
                    <input type="text" name="alt" placeholder="Alt text" required 
                           class="bg-gray-700 text-white border border-gray-600 p-2 rounded focus:outline-none focus:ring-2 focus:ring-yellow-400">
                    <input type="text" name="category" placeholder="Category" required 
                           class="bg-gray-700 text-white border border-gray-600 p-2 rounded focus:outline-none focus:ring-2 focus:ring-yellow-400">
                </div>
                <button type="submit" class="mt-2 bg-blue-500 text-white px-4 py-2 rounded hover:bg-blue-600">
                    Add Skill
                </button>
            </form>

            <!-- Edit Skill Form (Hidden by default) -->
            <div id="editSkillForm" class="hidden mb-6 p-4 border-2 border-red-400 rounded bg-red-100">
                <h3 class="text-lg font-bold mb-2 text-black">Edit Skill</h3>
                <form method="POST">
                    <input type="hidden" name="action" value="edit_skill">
                    <input type="hidden" id="editSkillId" name="id">
                    <div class="grid grid-cols-2 gap-4">
                        <input type="text" id="editSkillLogo" name="logo" placeholder="Logo path" required 
                            class="bg-gray-700 text-white border border-gray-600 p-2 rounded focus:outline-none focus:ring-2 focus:ring-yellow-400">
                        <input type="text" id="editSkillAlt" name="alt" placeholder="Alt text" required 
                            class="bg-gray-700 text-white border border-gray-600 p-2 rounded focus:outline-none focus:ring-2 focus:ring-yellow-400">
                        <input type="text" id="editSkillCategory" name="category" placeholder="Alt text" required 
                            class="bg-gray-700 text-white border border-gray-600 p-2 rounded focus:outline-none focus:ring-2 focus:ring-yellow-400">
                    </div>
                    <div class="mt-2">
                        <button type="submit" class="bg-green-500 text-white px-4 py-2 rounded hover:bg-green-600">
                            Update Skill
                        </button>
                        <button type="button" onclick="cancelEdit('editSkillForm')" 
                                class="ml-2 bg-gray-500 text-white px-4 py-2 rounded hover:bg-gray-600">
                            Cancel
                        </button>
                    </div>
                </form>
            </div>
            
            <!-- Skills List -->
            <div class="overflow-x-auto">
                <table class="w-full border-collapse border">
                    <thead>
                        <tr class="bg-gray-700 text-white">
                            <th class="border p-2">ID</th>
                            <th class="border p-2">Logo</th>
                            <th class="border p-2">Alt Text</th>
                            <th class="border p-2">Category</th>
                            <th class="border p-2">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <?php foreach ($skills as $skill): ?>
                        <tr class="text-white">
                            <td class="border p-2"><?php echo $skill['id']; ?></td>
                            <td class="border p-2"><?php echo htmlspecialchars($skill['logo_path']); ?></td>
                            <td class="border p-2"><?php echo htmlspecialchars($skill['alt']); ?></td>
                            <td class="border p-2"><?php echo htmlspecialchars($skill['category']); ?></td>
                            <td class="border p-2">
                                <button onclick="editSkill(<?php echo $skill['id']; ?>, '<?php echo htmlspecialchars($skill['logo_path']); ?>', '<?php echo htmlspecialchars($skill['alt']); ?>')" 
                                        class="bg-yellow-500 text-white px-2 py-1 rounded text-xs hover:bg-yellow-600 mr-1">
                                    Edit
                                </button>
                                <form method="POST" class="inline-block">
                                    <input type="hidden" name="action" value="delete_skill">
                                    <input type="hidden" name="id" value="<?php echo $skill['id']; ?>">
                                    <button type="submit" onclick="return confirm('Are you sure you want to delete this skill?')" 
                                            class="bg-red-500 text-white px-2 py-1 rounded text-xs hover:bg-red-600">
                                        Delete
                                    </button>
                                </form>
                            </td>
                        </tr>
                        <?php endforeach; ?>
                    </tbody>
                </table>
            </div>
        </div>

        <!-- Educations Section -->
        <div class="bg-gray-800 p-6 rounded-lg shadow-md mb-8 text-white">
            <h2 class="text-2xl font-bold mb-4">Educations</h2>
            
            <!-- Add Education Form -->
            <form method="POST" class="mb-6">
                <input type="hidden" name="action" value="add_education">
                <div class="grid grid-cols-3 gap-4">
                    <input type="text" name="title" placeholder="Title" required 
                           class="bg-gray-700 text-white border border-gray-600 p-2 rounded focus:outline-none focus:ring-2 focus:ring-yellow-400">
                    <input type="text" name="description" placeholder="Description" required 
                           class="bg-gray-700 text-white border border-gray-600 p-2 rounded focus:outline-none focus:ring-2 focus:ring-yellow-400">
                    <input type="text" name="img" placeholder="Image_Path" required 
                           class="bg-gray-700 text-white border border-gray-600 p-2 rounded focus:outline-none focus:ring-2 focus:ring-yellow-400">
                </div>
                <button type="submit" class="mt-2 bg-blue-500 text-white px-4 py-2 rounded hover:bg-blue-600">
                    Add Educations
                </button>
            </form>

            <!-- Edit Education Form (Hidden by default) -->
            <div id="editEducationForm" class="hidden mb-6 p-4 border-2 border-red-400 rounded bg-red-100">
                <h3 class="text-lg font-bold mb-2 text-black">Education</h3>
                <form method="POST">
                    <input type="hidden" name="action" value="edit_education">
                    <input type="hidden" id="editEducationId" name="id">
                    <div class="grid grid-cols-2 gap-4">
                        <input type="text" id="editEducationTitle" name="title" placeholder="Title" required 
                            class="bg-gray-700 text-white border border-gray-600 p-2 rounded focus:outline-none focus:ring-2 focus:ring-yellow-400">
                        <input type="text" id="editEducationDescription" name="description" placeholder="Description" required 
                            class="bg-gray-700 text-white border border-gray-600 p-2 rounded focus:outline-none focus:ring-2 focus:ring-yellow-400">
                        <input type="text" id="editEducationImg" name="img" placeholder="Image_Path" required 
                            class="bg-gray-700 text-white border border-gray-600 p-2 rounded focus:outline-none focus:ring-2 focus:ring-yellow-400">
                    </div>
                    <div class="mt-2">
                        <button type="submit" class="bg-green-500 text-white px-4 py-2 rounded hover:bg-green-600">
                            Update Skill
                        </button>
                        <button type="button" onclick="cancelEdit('editEducationForm')" 
                                class="ml-2 bg-gray-500 text-white px-4 py-2 rounded hover:bg-gray-600">
                            Cancel
                        </button>
                    </div>
                </form>
            </div>
            
            <!-- Education List -->
            <div class="overflow-x-auto">
                <table class="w-full border-collapse border">
                    <thead>
                        <tr class="bg-gray-700 text-white">
                            <th class="border p-2">ID</th>
                            <th class="border p-2">Title</th>
                            <th class="border p-2">Description</th>
                            <th class="border p-2">Image_Path</th>
                            <th class="border p-2">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <?php foreach ($educationList as $education): ?>
                        <tr class="text-white">
                            <td class="border p-2"><?php echo $education['id']; ?></td>
                            <td class="border p-2"><?php echo htmlspecialchars($education['title']); ?></td>
                            <td class="border p-2"><?php echo htmlspecialchars($education['description']); ?></td>
                            <td class="border p-2"><?php echo htmlspecialchars($education['image_path']); ?></td>
                            <td class="border p-2">
                                <button onclick="editEducation(<?php echo $education['id']; ?>, '<?php echo htmlspecialchars($education['title']); ?>', '<?php echo htmlspecialchars($education['description']); ?>', '<?php echo htmlspecialchars($education['image_path']); ?>')" 
                                        class="bg-yellow-500 text-white px-2 py-1 rounded text-xs hover:bg-yellow-600 mr-1">
                                    Edit
                                </button>
                                <form method="POST" class="inline-block">
                                    <input type="hidden" name="action" value="delete_education">
                                    <input type="hidden" name="id" value="<?php echo $education['id']; ?>">
                                    <button type="submit" onclick="return confirm('Are you sure you want to delete this skill?')" 
                                            class="bg-red-500 text-white px-2 py-1 rounded text-xs hover:bg-red-600">
                                        Delete
                                    </button>
                                </form>
                            </td>
                        </tr>
                        <?php endforeach; ?>
                    </tbody>
                </table>
            </div>
        </div>

        <!-- Experiences Section -->
        <div class="bg-gray-800 p-6 rounded-lg shadow-md mb-8 text-white">
            <h2 class="text-2xl font-bold mb-4">Experiences</h2>

            <!-- Add Experience Form -->
            <form method="POST" class="mb-6">
                <input type="hidden" name="action" value="add_experience">
                <div class="grid grid-cols-3 gap-4">
                    <input type="text" name="title" placeholder="Title" required
                        class="bg-gray-700 text-white border border-gray-600 p-2 rounded focus:outline-none focus:ring-2 focus:ring-yellow-400">
                    <input type="text" name="date_range" placeholder="Date Range" required
                        class="bg-gray-700 text-white border border-gray-600 p-2 rounded focus:outline-none focus:ring-2 focus:ring-yellow-400">
                    <textarea name="details" placeholder="Enter details (one per line)" required
                            class="bg-gray-700 text-white border border-gray-600 p-2 rounded focus:outline-none focus:ring-2 focus:ring-yellow-400 col-span-3"></textarea>
                </div>
                <button type="submit"
                        class="mt-2 bg-blue-500 text-white px-4 py-2 rounded hover:bg-blue-600">Add Experience</button>
            </form>

            <!-- Edit Experience Form (Hidden by default) -->
            <div id="editExperienceForm" class="hidden mb-6 p-4 border-2 border-red-400 rounded bg-red-100">
                <h3 class="text-lg font-bold mb-2 text-black">Edit Experience</h3>
                <form method="POST">
                    <input type="hidden" name="action" value="edit_experience">
                    <input type="hidden" id="editExperienceId" name="id">
                    <div class="grid grid-cols-2 gap-4">
                        <input type="text" id="editExperienceTitle" name="title" placeholder="Title" required
                            class="bg-gray-700 text-white border border-gray-600 p-2 rounded focus:outline-none focus:ring-2 focus:ring-yellow-400">
                        <input type="text" id="editExperienceDate" name="date_range" placeholder="Date Range" required
                            class="bg-gray-700 text-white border border-gray-600 p-2 rounded focus:outline-none focus:ring-2 focus:ring-yellow-400">
                    </div>
                    <textarea id="editExperienceDetails" name="details" placeholder="Details (one per line)" rows="5"
                            class="w-full mt-2 bg-gray-700 text-white border border-gray-600 p-2 rounded focus:outline-none focus:ring-2 focus:ring-yellow-400"></textarea>
                    <div class="mt-2">
                        <button type="submit"
                                class="bg-green-500 text-white px-4 py-2 rounded hover:bg-green-600">Update Experience</button>
                        <button type="button" onclick="cancelEdit('editExperienceForm')"
                                class="ml-2 bg-gray-500 text-white px-4 py-2 rounded hover:bg-gray-600">Cancel</button>
                    </div>
                </form>
            </div>

            <!-- Experiences List -->
            <div class="overflow-x-auto">
                <table class="w-full border-collapse border">
                    <thead>
                        <tr class="bg-gray-700 text-white">
                            <th class="border p-2">ID</th>
                            <th class="border p-2">Title</th>
                            <th class="border p-2">Date Range</th>
                            <th class="border p-2">Details</th>
                            <th class="border p-2">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <?php foreach ($experienceList as $experience): ?>
                        <tr class="text-white align-top">
                            <td class="border p-2"><?php echo $experience['id']; ?></td>
                            <td class="border p-2"><?php echo htmlspecialchars($experience['title']); ?></td>
                            <td class="border p-2"><?php echo htmlspecialchars($experience['date_range']); ?></td>
                            <td class="border p-2">
                                <ul class="list-disc pl-5 text-sm">
                                    <?php
                                    $details = $experienceDetailsMap[$experience['id']] ?? [];
                                    foreach ($details as $detail) {
                                        echo '<li>' . htmlspecialchars($detail) . '</li>';
                                    }
                                    ?>
                                </ul>
                            </td>
                            <td class="border p-2">
                                <button onclick="editExperience(
                                    <?php echo $experience['id']; ?>,
                                    '<?php echo htmlspecialchars($experience['title'], ENT_QUOTES); ?>',
                                    '<?php echo htmlspecialchars($experience['date_range'], ENT_QUOTES); ?>',
                                    `<?php echo htmlspecialchars(implode("\n", $details), ENT_QUOTES); ?>`
                                )"
                                    class="bg-yellow-500 text-white px-2 py-1 rounded text-xs hover:bg-yellow-600 mr-1">Edit</button>
                                <form method="POST" class="inline-block">
                                    <input type="hidden" name="action" value="delete_experience">
                                    <input type="hidden" name="id" value="<?php echo $experience['id']; ?>">
                                    <button type="submit" onclick="return confirm('Are you sure you want to delete this experience?')"
                                            class="bg-red-500 text-white px-2 py-1 rounded text-xs hover:bg-red-600">Delete</button>
                                </form>
                            </td>
                        </tr>
                        <?php endforeach; ?>
                    </tbody>
                </table>
            </div>
        </div>


        <!-- Contact Messages Section -->
        <div class="bg-gray-800 p-6 rounded-lg shadow-md mb-8 text-white">
            <h2 class="text-2xl font-bold mb-4">Contact Messages</h2>
            
            <div class="overflow-x-auto">
                <table class="w-full border-collapse border">
                    <thead>
                        <tr class="bg-gray-700 text-white">
                            <th class="border p-2">ID</th>
                            <th class="border p-2">Name</th>
                            <th class="border p-2">Email</th>
                            <th class="border p-2">Subject</th>
                            <th class="border p-2">Message</th>
                            <th class="border p-2">Date</th>
                            <th class="border p-2">Status</th>
                        </tr>
                    </thead>
                    <tbody class="text-white">
                        <?php foreach ($messages as $message): ?>
                        <tr class="<?php echo $message['status'] ? '' : 'bg-gray-800'; ?>">
                            <td class="border p-2"><?php echo $message['id']; ?></td>
                            <td class="border p-2"><?php echo htmlspecialchars($message['name']); ?></td>
                            <td class="border p-2"><?php echo htmlspecialchars($message['email']); ?></td>
                            <td class="border p-2"><?php echo htmlspecialchars($message['subject']); ?></td>
                            <td class="border p-2 max-w-xs truncate" title="<?php echo htmlspecialchars($message['message']); ?>">
                                <?php echo htmlspecialchars(substr($message['message'], 0, 50)) . '...'; ?>
                            </td>
                            <td class="border p-2"><?php echo date('Y-m-d H:i', strtotime($message['created_at'])); ?></td>
                            <td class="border p-2">
                                <span class="px-2 py-1 text-xs rounded <?php echo $message['status'] ? 'bg-green-100 text-green-800' : 'bg-red-100 text-red-800'; ?>">
                                    <?php echo $message['status'] ? 'Read' : 'Unread'; ?>
                                </span>

                                <?php if (!$message['status']): ?>
                                    <form method="POST" class="inline-block ml-2">
                                        <input type="hidden" name="action" value="toggle_read_status">
                                        <input type="hidden" name="message_id" value="<?php echo $message['id']; ?>">
                                        <button type="submit" class="bg-blue-500 text-white text-xs px-2 py-1 rounded hover:bg-blue-600">
                                            Mark as Read
                                        </button>
                                    </form>
                                <?php endif; ?>
                            </td>
                        </tr>
                        <?php endforeach; ?>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
    <script>
        function editProject(id, count, label) {
            document.getElementById('editProjectId').value = id;
            document.getElementById('editProjectCount').value = count;
            document.getElementById('editProjectLabel').value = label;
            document.getElementById('editProjectForm').classList.remove('hidden');
        }

        function editCompetency(id, title, description, img, alt) {
            document.getElementById('editCompetencyId').value = id;
            document.getElementById('editCompetencyTitle').value = title;
            document.getElementById('editCompetencyDescription').value = description;
            document.getElementById('editCompetencyImg').value = img;
            document.getElementById('editCompetencyAlt').value = alt;
            document.getElementById('editCompetencyForm').classList.remove('hidden');
        }

        function editEducation(id, title, description, img) {
            document.getElementById('editEducationId').value = id;
            document.getElementById('editEducationTitle').value = title;
            document.getElementById('editEducationDescription').value = description;
            document.getElementById('editEducationImg').value = img;
            document.getElementById('editEducationForm').classList.remove('hidden');
        }

        function editExperience(id, title, dateRange, details) {
            document.getElementById('editExperienceId').value = id;
            document.getElementById('editExperienceTitle').value = title;
            document.getElementById('editExperienceDate').value = dateRange;
            document.getElementById('editExperienceDetails').value = details;
            document.getElementById('editExperienceForm').classList.remove('hidden');
        }

        function editSkill(id, logo, alt, category) {
            document.getElementById('editSkillId').value = id;
            document.getElementById('editSkillLogo').value = logo;
            document.getElementById('editSkillAlt').value = alt;
            document.getElementById('editSkillCategory').value = category;
            document.getElementById('editSkillForm').classList.remove('hidden');
        }

        function cancelEdit(formId) {
            document.getElementById(formId).classList.add('hidden');
        }
    </script>
</body>
</html>