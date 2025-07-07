document.addEventListener('DOMContentLoaded', function() {
  AOS.init();
  
  // Updated API base URL for new folder structure
  const API_BASE_URL = 'api/portfolio_api.php';
  
  // Add this temporary test to your script.js to debug
  async function testAPI() {
    try {
      console.log('Testing API URL:', `${API_BASE_URL}?action=contact`);
      const response = await fetch(`${API_BASE_URL}?action=contact`, {
        method: 'GET' // Test with GET first
      });
      
      console.log('Response status:', response.status);
      console.log('Response headers:', [...response.headers.entries()]);
      
      const text = await response.text();
      console.log('Raw response:', text);
      
      // Try to parse as JSON
      try {
        const json = JSON.parse(text);
        console.log('Parsed JSON:', json);
      } catch (e) {
        console.log('Not valid JSON - response is HTML/text');
      }
    } catch (error) {
      console.error('API test failed:', error);
    }
  }

  // Call this function in browser console to test
  // testAPI();

  // Map toggle functionality
  const mapToggle = document.getElementById('mapInvertToggle');
  const mapIframe = document.getElementById('googleMap');
  
  if (mapToggle && mapIframe) {
    mapToggle.addEventListener('click', function() {
      // Toggle invert filter
      if (mapIframe.style.filter === 'invert(1)') {
        mapIframe.style.filter = 'none';
      } else {
        mapIframe.style.filter = 'invert(1)';
      }
    });
  }

  // Hamburger menu functionality
  const hamburgerBtn = document.getElementById('hamburgerBtn');
  const mobileMenu = document.getElementById('mobileMenu');
  
  if (hamburgerBtn && mobileMenu) {
    // Ensure menu is hidden on load
    mobileMenu.style.maxHeight = '0px';
    mobileMenu.style.paddingTop = '0';
    mobileMenu.style.paddingBottom = '0';

    hamburgerBtn.addEventListener('click', () => {
      if (mobileMenu.style.maxHeight === '0px' || mobileMenu.style.maxHeight === '') {
        mobileMenu.style.maxHeight = '350px';
        mobileMenu.style.paddingTop = '1.5rem';
        mobileMenu.style.paddingBottom = '1.5rem';
      } else {
        mobileMenu.style.maxHeight = '0px';
        mobileMenu.style.paddingTop = '0';
        mobileMenu.style.paddingBottom = '0';
      }
    });
  }

  // Helper function to make API calls
  async function fetchFromAPI(endpoint) {
    try {
      const response = await fetch(`${API_BASE_URL}?action=${endpoint}`);
      if (!response.ok) {
        throw new Error(`HTTP error! status: ${response.status}`);
      }
      return await response.json();
    } catch (error) {
      console.error(`Failed to fetch ${endpoint}:`, error);
      throw error;
    }
  }

  // Dynamic project cards loading
  fetchFromAPI('projects')
    .then(data => {
      const container = document.getElementById('project-container');
      data.forEach((project, index) => {
        const card = document.createElement('div');
        card.className = 'h-[25vh] w-[45vh] md:w-[38vh] bg-[#272E32] flex flex-col justify-around items-center';
        card.setAttribute("data-aos", "flip-right");
        card.setAttribute("data-aos-delay", index * 200);
        card.innerHTML = `
          <div class="pb-5">
            <div class="text-[#FFB22C] text-[50pt] font-bold">${project.count}</div>
            <div class="text-white text-2xl">${project.label}</div>
          </div>
        `;
        container.appendChild(card);
      });
      AOS.refresh(); // Refresh AOS after adding new elements
    })
    .catch(error => {
      console.error('Failed to load project data:', error);
      showError('Failed to load project data. Please try again later.');
    });

  // Dynamic competency cards loading
  fetchFromAPI('competencies')
    .then(data => {
      const container = document.getElementById('competency-container');
      const firstThreeReversed = 3;
      
      data.forEach((item, index) => {
        const card = document.createElement('div');
        card.className = 'h-full w-full bg-[#272E32] flex justify-center items-center';
        card.setAttribute('data-aos', 'flip-left');
        
        let delay;
        if (index < firstThreeReversed) {
          delay = (firstThreeReversed - 1 - index) * 200;
        } else {
          delay = index * 200;
        }
        
        card.setAttribute('data-aos-delay', delay);
        
        card.innerHTML = `
          <div class="flex h-fit w-fit flex-col justify-center p-10 gap-4">
            <img src="${item.img}" alt="${item.alt}" class="h-14 w-fit pb-4">
            <p class="text-white text-3xl font-bold">${item.title}</p>
            <p class="text-white text-lg">${item.desc}</p>
          </div>
        `;
        container.appendChild(card);
      });
      AOS.refresh();
    })
    .catch(error => {
      console.error('Failed to load competency data:', error);
      showError('Failed to load competency data. Please try again later.');
    });

  // Dynamic education and experience loading
  fetchFromAPI('education_experience')
    .then(data => {
      const eduContainer = document.getElementById('education-container');
      const expContainer = document.getElementById('experience-container');

      // Education
      data.education.forEach((edu, index) => {
        const card = document.createElement('div');
        card.className = 'bg-[#272E32] w-fit flex flex-col justify-center gap-3 p-14 mx-12';
        card.setAttribute('data-aos', 'fade-right');
        card.setAttribute('data-aos-delay', index * 400);
        card.innerHTML = `
          <img src="${edu.img}" alt="education" class="w-20 md:w-28 h-auto">
          <div class="text-[#FFB22C] text-2xl font-bold">${edu.title}</div>
          <p class="text-white text-md md:text-xl max-w-sm">${edu.desc}</p>
        `;
        eduContainer.appendChild(card);
      });

      // Experience
      data.experience.forEach(exp => {
        const card = document.createElement('div');
        card.className = 'h-fit w-[80%] flex flex-col p-5 gap-2 md:gap-5';

        const details = exp.details.map((detail, index) =>
          `<p class="text-[#D9D9D9] font-bold text-sm md:text-xl">- ${detail}</p>`
        ).join('');

        card.setAttribute('data-aos', 'fade-up');
        card.setAttribute('data-aos-delay', exp.details.length * 200);
        card.innerHTML = `
          <div class="text-white font-bold text-3xl md:text-5xl">${exp.title}</div>
          <div class="text-[#D9D9D9] font-bold text-sm md:text-lg pb-2">${exp.date}</div>
          ${details}
        `;
        expContainer.appendChild(card);
      });
      AOS.refresh();
    })
    .catch(error => {
      console.error('Failed to load education/experience data:', error);
      showError('Failed to load education/experience data. Please try again later.');
    });


  let allSkills = []; // Store all skills globally
  fetchFromAPI('skills')
      .then(data => {
          allSkills = data; // Store all skills
          const cyberSkills = allSkills.filter(skill => skill.category === 'cyber');
          renderSkills(cyberSkills); // Render all skills initially
          setupSkillTabs(); // Setup tab functionality
          updateTabVisibility(); // Update tab button visibility based on available categories
      })
      .catch(error => {
          console.error('Failed to load skill data:', error);
          showError('Failed to load skill data. Please try again later.');
      });

  // Enhanced function to render skills with category filtering
  function renderSkills(skills) {
      const skillContainer = document.getElementById('skill-container');
      skillContainer.innerHTML = ''; // Clear existing content

      // Show message if no skills found for the category
      if (skills.length === 0) {
          skillContainer.innerHTML = `
              <div class="col-span-full text-center text-white text-xl">
                  <p class="mb-4">No skills found in this category</p>
                  <p class="text-gray-400 text-lg">Skills are being organized and will be available soon!</p>
              </div>
          `;
          return;
      }

      skills.forEach((skill, index) => {
          const card = document.createElement('div');
          card.className = 'card-3d skill-card';
          card.setAttribute('data-category', skill.category);
          card.setAttribute('data-aos', 'flip-left');
          card.setAttribute('data-aos-delay', index * 50);
          
          const cardInner = document.createElement('div');
          cardInner.className = `
              card-3d-inner bg-[#272E32] h-[200px] md:h-[250px] w-full 
              flex justify-center items-center 
              rounded-2xl shadow-xl
          `;
          cardInner.innerHTML = `
              <img src="${skill.logo}" alt="${skill.alt}" class="w-24 h-auto m-14">
          `;

          // Add mouse movement effect
          card.addEventListener('mousemove', (e) => {
              const rect = card.getBoundingClientRect();
              const x = e.clientX - rect.left;
              const y = e.clientY - rect.top;

              const centerX = rect.width / 2;
              const centerY = rect.height / 2;

              const rotateX = -(y - centerY) / 10;
              const rotateY = (x - centerX) / 10;

              cardInner.classList.add('glowing');
              cardInner.style.transform = `rotateX(${rotateX}deg) rotateY(${rotateY}deg) scale(1.05)`;
          });

          card.addEventListener('mouseleave', () => {
              cardInner.style.transform = `rotateX(0deg) rotateY(0deg) scale(1)`;
              cardInner.classList.remove('glowing');
          });

          card.appendChild(cardInner);
          skillContainer.appendChild(card);
      });
      AOS.refresh();
  }

  function setupSkillTabs() {
      const tabButtons = document.querySelectorAll('.skill-tab-btn');
      
      tabButtons.forEach(button => {
          button.addEventListener('click', () => {
              const category = button.getAttribute('data-category');
              
              // Update active button
              tabButtons.forEach(btn => {
                  btn.classList.remove('active', 'bg-[#FFB22C]', 'text-black');
                  btn.classList.add('bg-[#272E32]', 'text-white');
              });
              
              button.classList.add('active', 'bg-[#FFB22C]', 'text-black');
              button.classList.remove('bg-[#272E32]', 'text-white');
              
              // Filter skills based on category (removed the "all" condition)
              const filteredSkills = allSkills.filter(skill => skill.category === category);
              renderSkills(filteredSkills);
          });
      });
  }

  // Updated updateTabVisibility function - remove the "all" category condition
  function updateTabVisibility() {
      const tabButtons = document.querySelectorAll('.skill-tab-btn');
      const availableCategories = [...new Set(allSkills.map(skill => skill.category))];
      
      tabButtons.forEach(button => {
          const category = button.getAttribute('data-category');
          
          // Only show category buttons if there are skills in that category
          if (availableCategories.includes(category)) {
              button.style.display = 'block';
          } else {
              button.style.display = 'none';
          }
      });
  }

  // Dynamic about links loading
  fetchFromAPI('about')
    .then(data => {
      const aboutContainer = document.getElementById('about-container');
      data.forEach(about => {
        const link = document.createElement('a');
        link.href = about.url;
        link.target = '_blank';
        link.rel = 'noopener noreferrer';

        const img = document.createElement('img');
        img.className = 'w-fit h-8 hover:scale-125 transform duration-300';
        img.src = about.logo;
        img.alt = about.alt;

        link.appendChild(img);
        aboutContainer.appendChild(link);
      });
    })
    .catch(error => {
      console.error('Failed to load about data:', error);
      showError('Failed to load social links. Please try again later.');
    });

  // Contact form submission - Enhanced version
  const contactForm = document.getElementById('contactForm');
  if (contactForm) {
    contactForm.addEventListener('submit', async function(e) {
      console.log('CAPTCHA OPENING!');
      e.preventDefault();
      
      const submitBtn = contactForm.querySelector('button[type="submit"]');
      const originalBtnText = submitBtn ? submitBtn.textContent : '';
      
      const formData = {
        name: document.getElementById('name').value.trim(),
        email: document.getElementById('email').value.trim(),
        subject: document.getElementById('subject').value.trim(),
        message: document.getElementById('description').value.trim()
      };

      // Basic validation
      if (!formData.name || !formData.email || !formData.subject || !formData.message) {
        showError('Please fill in all fields.');
        return;
      }

      // Show captcha modal
      showMathCaptcha(formData);
    });
  }

  // Math captcha functionality
  function showMathCaptcha(formData) {
    const modal = document.getElementById('captchaModal');
    const questionEl = document.getElementById('mathQuestion');
    const answerEl = document.getElementById('mathAnswer');
    const errorEl = document.getElementById('captchaError');
    
    // Generate random math problem
    const num1 = Math.floor(Math.random() * 20) + 1;
    const num2 = Math.floor(Math.random() * 20) + 1;
    const operation = Math.random() > 0.5 ? '+' : '-';
    const correctAnswer = operation === '+' ? num1 + num2 : num1 - num2;
    
    questionEl.textContent = `${num1} ${operation} ${num2} = ?`;
    answerEl.value = '';
    errorEl.classList.add('hidden');
    modal.classList.remove('hidden');
    answerEl.focus();
    
    // Handle captcha submission
    const submitHandler = () => {
      const userAnswer = parseInt(answerEl.value);
      if (userAnswer === correctAnswer) {
        modal.classList.add('hidden');
        submitContactForm(formData);
      } else {
        errorEl.textContent = 'Incorrect answer. Please try again.';
        errorEl.classList.remove('hidden');
        answerEl.value = '';
        answerEl.focus();
      }
    };
    
    // Handle cancel
    const cancelHandler = () => {
      modal.classList.add('hidden');
    };
    
    // Add event listeners
    document.getElementById('captchaSubmit').onclick = submitHandler;
    document.getElementById('captchaCancel').onclick = cancelHandler;
    
    // Allow Enter key to submit
    answerEl.onkeypress = (e) => {
      if (e.key === 'Enter') {
        submitHandler();
      }
    };
    
    // Allow Escape key to cancel
    document.onkeydown = (e) => {
      if (e.key === 'Escape' && !modal.classList.contains('hidden')) {
        cancelHandler();
      }
    };
  }

  // Extract the actual form submission logic
  async function submitContactForm(formData) {
    const submitBtn = contactForm.querySelector('button[type="submit"]');
    const originalBtnText = submitBtn ? submitBtn.textContent : '';
    
    // Show loading state
    if (submitBtn) {
      submitBtn.disabled = true;
      submitBtn.textContent = 'Sending...';
      submitBtn.classList.add('opacity-50', 'cursor-not-allowed');
    }

    try {
      console.log('Submitting to:', `${API_BASE_URL}?action=contact`);
      console.log('Form data:', formData);

      const response = await fetch(`${API_BASE_URL}?action=contact`, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify(formData)
      });

      console.log('Response status:', response.status);
      console.log('Response content-type:', response.headers.get('content-type'));

      // Get the response text first
      const responseText = await response.text();
      console.log('Raw response:', responseText);

      // Try to parse as JSON
      let result;
      try {
        result = JSON.parse(responseText);
      } catch (parseError) {
        console.error('JSON parse error:', parseError);
        console.error('Response was:', responseText);
        throw new Error('Server returned invalid response. Check console for details.');
      }

      if (response.ok) {
        showSuccess('Message sent successfully! Thank you for contacting me.');
        contactForm.reset();
      } else {
        showError(result.error || 'Failed to send message. Please try again.');
      }
    } catch (error) {
      console.error('Error submitting contact form:', error);
      showError(error.message || 'Network error. Please check your connection and try again.');
    } finally {
      // Reset button state
      if (submitBtn) {
        submitBtn.disabled = false;
        submitBtn.textContent = originalBtnText;
        submitBtn.classList.remove('opacity-50', 'cursor-not-allowed');
      }
    }
  }

  // Utility functions for showing messages
  function showError(message) {
    createNotification(message, 'error');
  }

  function showSuccess(message) {
    createNotification(message, 'success');
  }

  function createNotification(message, type) {
    const notification = document.createElement('div');
    notification.className = `fixed top-4 right-4 p-4 rounded-lg text-white font-bold z-50 ${
      type === 'error' ? 'bg-red-500' : 'bg-green-500'
    }`;
    notification.textContent = message;
    
    document.body.appendChild(notification);
    
    setTimeout(() => {
      notification.remove();
    }, 5000);
  }
});