import Foundation

// Knowledge base for STAC-specific information
class KnowledgeBase {
    static let shared = KnowledgeBase()
    
    // Sample documents for RAG (in a real implementation, this would be stored externally)
    let documents: [Document] = [
        Document(
            id: "stac-history",
            content: "St. Thomas Aquinas College was founded in 1952 by the Dominican Sisters of Sparkill. It is located in Sparkill, NY and offers over 100 programs across three schools: Arts & Sciences, Business, and Education. The college's mission is to provide a values-based education that emphasizes academic excellence, ethical leadership, and social responsibility. The college has grown significantly since its founding, now serving over 2,000 students with modern facilities and a commitment to academic excellence.",
            metadata: ["category": "about", "type": "history"]
        ),
        Document(
            id: "academics-programs",
            content: "STAC offers undergraduate and graduate programs across three schools. The School of Arts & Sciences includes majors in Psychology, Biology, Communication Arts, and Criminal Justice. The School of Business offers programs in Accounting, Finance, Management, Marketing, and Sport Management. The School of Education provides teacher certification programs for various grade levels and subjects. The college also offers accelerated degree programs, online courses, and study abroad opportunities.",
            metadata: ["category": "academics", "type": "programs"]
        ),
        Document(
            id: "campus-resources",
            content: "STAC's campus resources include the Lougheed Library, which provides research materials, study spaces, and academic support services. The Center for Academic Excellence offers tutoring and writing assistance. The Career Development Center helps with internships, job searches, and career planning. The Kraus Fitness Center offers workout facilities and recreation programs. Additional resources include the Writing Center, Math Lab, and Disability Services.",
            metadata: ["category": "campus", "type": "resources"]
        ),
        Document(
            id: "student-life",
            content: "STAC offers a vibrant student life with over 40 clubs and organizations, NCAA Division II athletics, and various events throughout the academic year. The Student Activities Board organizes campus events, and students can join clubs related to their interests or major. Residential Life provides housing options for students living on campus, with activities and support services. The college hosts annual events like Homecoming, Spring Weekend, and various cultural celebrations.",
            metadata: ["category": "campus", "type": "student life"]
        ),
        Document(
            id: "admissions",
            content: "STAC's admissions process involves submitting an application, transcripts, and optional test scores. The college offers financial aid packages including scholarships, grants, loans, and work-study programs. Transfer students can receive credit for previous coursework at accredited institutions. Prospective students can schedule campus tours and attend open house events. The college has rolling admissions and offers early decision options.",
            metadata: ["category": "admissions", "type": "process"]
        ),
        Document(
            id: "contact-info",
            content: "The main campus of St. Thomas Aquinas College is located at 125 Route 340, Sparkill, NY 10976. The main phone number is (845) 398-4000. The Admissions Office can be reached at (845) 398-4100 or admissions@stac.edu. The Financial Aid Office can be contacted at (845) 398-4060 or financialaid@stac.edu. The Registrar's Office is at (845) 398-4040.",
            metadata: ["category": "contact", "type": "info"]
        ),
        Document(
            id: "academic-support",
            content: "STAC provides comprehensive academic support services through the Center for Academic Excellence. Services include one-on-one tutoring, group study sessions, writing assistance, and academic coaching. The Writing Center helps students with all stages of the writing process, while the Math Lab offers support for mathematics courses. Disability Services provides accommodations for students with documented disabilities.",
            metadata: ["category": "academics", "type": "support"]
        ),
        Document(
            id: "athletics",
            content: "STAC Spartans compete in NCAA Division II athletics. The college offers 16 varsity sports including basketball, soccer, baseball, softball, lacrosse, and track & field. The Spartan Athletic Complex features state-of-the-art facilities for training and competition. Student-athletes receive academic support and have access to athletic training services. The college also offers intramural sports and fitness programs.",
            metadata: ["category": "campus", "type": "athletics"]
        ),
        Document(
            id: "housing",
            content: "STAC offers several housing options for students. McNelis Commons provides traditional dormitory-style living, while Fitzpatrick Village offers suite-style apartments for upperclassmen. All residence halls include common areas, laundry facilities, and study spaces. Residential Life staff organize activities and provide support for students living on campus. Housing applications are typically due in the spring semester.",
            metadata: ["category": "campus", "type": "housing"]
        ),
        Document(
            id: "dining",
            content: "STAC's dining services are managed by Chartwells and offer a variety of meal options. The Romano Student Center features the Spartan Grille, offering coffee, snacks, and grab-and-go items. McNelis Commons provides all-you-care-to-eat dining with multiple stations including vegetarian and allergen-free options. Meal plans are available for both residential and commuter students.",
            metadata: ["category": "campus", "type": "dining"]
        ),
        Document(
            id: "career-services",
            content: "The Career Development Center at STAC offers comprehensive career services including resume writing, interview preparation, and job search strategies. The center hosts career fairs, networking events, and employer information sessions. Students can access Handshake, an online job and internship platform. The center also provides graduate school advising and alumni networking opportunities.",
            metadata: ["category": "career", "type": "services"]
        ),
        Document(
            id: "international-students",
            content: "STAC welcomes international students and provides support through the International Student Services office. Services include visa assistance, cultural adjustment support, and international student orientation. The college offers English language support and cultural programming. International students can participate in the International Student Association and various cultural events.",
            metadata: ["category": "admissions", "type": "international"]
        ),
        Document(
            id: "alumni",
            content: "STAC's alumni network includes over 20,000 graduates worldwide. The Alumni Association organizes events, networking opportunities, and career mentoring programs. Alumni can access career services, library resources, and campus facilities. The college maintains strong connections with alumni through regional chapters and professional networking groups.",
            metadata: ["category": "about", "type": "alumni"]
        ),
        Document(
            id: "library-services",
            content: "The Lougheed Library provides extensive resources including print and electronic collections, research databases, and interlibrary loan services. The library offers study spaces, computer labs, and group study rooms. Librarians provide research assistance and information literacy instruction. The library is open extended hours during exam periods and offers 24/7 access to online resources.",
            metadata: ["category": "campus", "type": "library"]
        ),
        Document(
            id: "health-services",
            content: "STAC's Health Services provides basic medical care, health education, and wellness programs. Services include first aid, health screenings, and referrals to local healthcare providers. The office maintains student health records and provides information about health insurance options. Mental health counseling is available through the Counseling Center.",
            metadata: ["category": "campus", "type": "health"]
        ),
        Document(
            id: "technology",
            content: "STAC provides comprehensive technology resources including campus-wide WiFi, computer labs, and printing services. Students have access to Microsoft Office 365, learning management systems, and academic software. The IT Help Desk offers technical support and assistance with device setup. The college maintains up-to-date technology in classrooms and labs.",
            metadata: ["category": "campus", "type": "technology"]
        ),
        Document(
            id: "arts-sciences",
            content: "The School of Arts & Sciences at STAC offers diverse programs including Psychology, Biology, Communication Arts, Criminal Justice, and more. The Psychology program features research opportunities and state-of-the-art labs. The Biology department offers modern laboratory facilities and research opportunities in molecular biology, ecology, and physiology. The Communication Arts program includes digital media production, journalism, and public relations tracks. Criminal Justice students benefit from internships with local law enforcement and forensic science labs.",
            metadata: ["category": "academics", "type": "departments"]
        ),
        Document(
            id: "business-school",
            content: "The School of Business at STAC offers programs in Accounting, Finance, Management, Marketing, and Sport Management. The Accounting program prepares students for CPA certification with specialized courses and internship opportunities. The Finance program includes investment analysis and financial planning tracks. The Sport Management program offers hands-on experience through partnerships with local sports organizations. All business programs emphasize real-world applications and professional development.",
            metadata: ["category": "academics", "type": "departments"]
        ),
        Document(
            id: "education-school",
            content: "The School of Education at STAC provides teacher certification programs for various grade levels and subjects. Programs include Childhood Education (Grades 1-6), Adolescence Education (Grades 7-12), and Special Education. The school maintains partnerships with local school districts for student teaching placements. The Education Resource Center provides materials and technology for teacher preparation. Students benefit from small class sizes and personalized mentoring from faculty.",
            metadata: ["category": "academics", "type": "departments"]
        ),
        Document(
            id: "research-opportunities",
            content: "STAC offers numerous research opportunities across disciplines. The Undergraduate Research Program supports student-faculty research collaborations. The Summer Research Institute provides intensive research experiences with faculty mentors. Students can present their research at the annual Research Symposium and regional conferences. Research areas include STEM fields, social sciences, humanities, and business. Funding is available through various grants and scholarships.",
            metadata: ["category": "academics", "type": "research"]
        ),
        Document(
            id: "study-abroad",
            content: "STAC offers study abroad programs in various countries including Italy, Spain, Ireland, and Australia. Programs range from short-term faculty-led trips to semester-long exchanges. The college maintains partnerships with universities worldwide. Financial aid can be applied to study abroad programs. The Office of International Programs provides pre-departure orientation and support services. Students can earn academic credit while experiencing different cultures.",
            metadata: ["category": "academics", "type": "international"]
        ),
        Document(
            id: "campus-safety",
            content: "STAC's Campus Safety Department operates 24/7 to ensure a secure environment. Services include emergency response, safety escorts, and vehicle assistance. The college has an emergency notification system for campus alerts. Residence halls have controlled access and security cameras. Campus Safety officers are trained in first aid and emergency response. The department also provides safety education programs and crime prevention resources.",
            metadata: ["category": "campus", "type": "safety"]
        ),
        Document(
            id: "student-organizations",
            content: "STAC has over 40 student organizations including academic clubs, cultural groups, and special interest organizations. The Student Government Association represents student interests and allocates funding. Cultural organizations include the Black Student Union, Latin American Student Association, and Asian Student Association. Special interest groups range from the Gaming Club to the Environmental Club. New organizations can be established through the Office of Student Activities.",
            metadata: ["category": "campus", "type": "organizations"]
        ),
        Document(
            id: "performing-arts",
            content: "STAC offers various performing arts opportunities through the Sullivan Theatre and music programs. The Theatre Arts program produces several productions each year. The Music Department offers ensembles including choir, jazz band, and chamber music. The college hosts guest artists and performances throughout the year. Students can participate in theatre productions, musical performances, and dance showcases. The Arts Center features state-of-the-art performance spaces.",
            metadata: ["category": "campus", "type": "arts"]
        ),
        Document(
            id: "sustainability",
            content: "STAC is committed to sustainability through various initiatives. The college has implemented energy-efficient lighting and HVAC systems. Recycling programs are available throughout campus. The Environmental Club promotes sustainable practices and organizes clean-up events. The college maintains green spaces and native plant gardens. Sustainability is integrated into academic programs and campus operations.",
            metadata: ["category": "campus", "type": "sustainability"]
        ),
        Document(
            id: "transportation",
            content: "STAC provides various transportation options for students. The college operates a shuttle service to local train stations and shopping areas. Carpooling programs are available for commuter students. Bike racks are located throughout campus. The college is accessible via public transportation, with nearby bus stops and train stations. Parking permits are available for students with vehicles.",
            metadata: ["category": "campus", "type": "transportation"]
        ),
        Document(
            id: "religious-life",
            content: "STAC maintains its Catholic identity while welcoming students of all faiths. Campus Ministry offers daily Mass, retreats, and service opportunities. The college celebrates major religious holidays and traditions. Interfaith dialogue and events promote religious understanding. The Chapel of the Holy Family serves as a spiritual center for the campus community. Students can participate in various religious and service organizations.",
            metadata: ["category": "campus", "type": "religious"]
        ),
        Document(
            id: "first-year-experience",
            content: "STAC's First-Year Experience program helps new students transition to college life. The program includes orientation, academic advising, and peer mentoring. First-year seminars introduce students to college-level work and campus resources. Learning communities connect students with similar academic interests. The program emphasizes academic success, personal development, and campus engagement.",
            metadata: ["category": "academics", "type": "first-year"]
        ),
        Document(
            id: "graduate-programs",
            content: "STAC offers graduate programs in Education, Business, and Criminal Justice. The Master of Science in Education includes specializations in Literacy, Special Education, and Educational Leadership. The MBA program offers concentrations in Management, Finance, and Marketing. The Master of Science in Criminal Justice provides advanced training for law enforcement and security professionals. Graduate students benefit from flexible scheduling and online course options.",
            metadata: ["category": "academics", "type": "graduate"]
        ),
        Document(
            id: "veteran-services",
            content: "STAC provides comprehensive support for veteran students. The Veterans Resource Center offers academic advising and career services. The college participates in the Yellow Ribbon Program and accepts GI Bill benefits. Veteran students have access to specialized counseling and support groups. The college maintains a Veterans Club and hosts events for military-affiliated students. Academic credit may be awarded for military training and experience.",
            metadata: ["category": "campus", "type": "veteran"]
        ),
        Document(
            id: "community-engagement",
            content: "STAC promotes community engagement through service-learning and volunteer opportunities. The Center for Community Engagement coordinates partnerships with local organizations. Students can participate in service trips, community projects, and volunteer programs. The college hosts annual service events like the Day of Service. Community engagement is integrated into academic programs and student life.",
            metadata: ["category": "campus", "type": "community"]
        ),
        Document(
            id: "developer-info",
            content: "StacGPT was developed by Bitania Yonas, a talented developer dedicated to creating innovative solutions for the St. Thomas Aquinas College community. The app combines advanced AI technology with comprehensive college information to provide students with instant access to campus resources and support.",
            metadata: ["category": "about", "type": "developer"]
        ),
        Document(
            id: "stem-programs",
            content: "STAC's STEM programs include Biology, Chemistry, Computer Science, and Mathematics. The Biology program offers concentrations in Pre-Med, Pre-Vet, and Environmental Science. The Chemistry program features modern laboratories and research opportunities in organic, inorganic, and analytical chemistry. Computer Science students learn programming, software development, and cybersecurity. Mathematics majors can specialize in pure mathematics, applied mathematics, or mathematics education.",
            metadata: ["category": "academics", "type": "programs"]
        ),
        Document(
            id: "humanities",
            content: "The Humanities Department at STAC offers programs in English, History, Philosophy, and Religious Studies. English majors can focus on literature, creative writing, or professional writing. History students explore American, European, and World History with opportunities for archival research. Philosophy courses cover ethics, logic, and the history of philosophy. Religious Studies examines world religions, theology, and religious traditions.",
            metadata: ["category": "academics", "type": "departments"]
        ),
        Document(
            id: "social-sciences",
            content: "STAC's Social Sciences programs include Psychology, Sociology, Political Science, and Criminal Justice. Psychology students can specialize in clinical, developmental, or experimental psychology. Sociology courses cover social theory, research methods, and social issues. Political Science examines government, international relations, and public policy. Criminal Justice includes courses in law enforcement, corrections, and forensic science.",
            metadata: ["category": "academics", "type": "departments"]
        ),
        Document(
            id: "communication-arts",
            content: "The Communication Arts program at STAC offers concentrations in Digital Media, Journalism, and Public Relations. Digital Media students learn video production, graphic design, and web development. Journalism courses cover news writing, reporting, and multimedia storytelling. Public Relations includes courses in strategic communication, social media management, and crisis communication. The program features a modern media lab and internship opportunities.",
            metadata: ["category": "academics", "type": "programs"]
        ),
        Document(
            id: "business-specializations",
            content: "STAC's Business School offers specialized tracks in various fields. Accounting students can pursue CPA preparation with courses in auditing, taxation, and financial accounting. Finance majors study investment analysis, financial planning, and corporate finance. Management students learn organizational behavior, human resources, and strategic management. Marketing includes courses in digital marketing, consumer behavior, and brand management.",
            metadata: ["category": "academics", "type": "programs"]
        ),
        Document(
            id: "education-certification",
            content: "STAC's Education programs prepare students for New York State teacher certification. Childhood Education (Grades 1-6) includes methods courses in literacy, mathematics, science, and social studies. Adolescence Education (Grades 7-12) offers subject-specific certification in English, Mathematics, Science, and Social Studies. Special Education programs prepare teachers to work with students with disabilities. All programs include extensive field experiences and student teaching.",
            metadata: ["category": "academics", "type": "programs"]
        ),
        Document(
            id: "honors-program",
            content: "STAC's Honors Program offers enhanced academic opportunities for high-achieving students. The program includes specialized honors courses, research opportunities, and cultural experiences. Honors students participate in seminars, attend cultural events, and complete a capstone project. Benefits include priority registration, dedicated honors housing, and special scholarships. The program emphasizes critical thinking, research skills, and intellectual curiosity.",
            metadata: ["category": "academics", "type": "programs"]
        ),
        Document(
            id: "internship-programs",
            content: "STAC's Internship Program connects students with professional opportunities in various fields. The Career Development Center helps students find internships in business, education, healthcare, and non-profit organizations. Academic departments maintain partnerships with local employers for field placements. Students can earn academic credit for internships and gain valuable work experience. The program includes resume workshops, interview preparation, and networking events.",
            metadata: ["category": "career", "type": "programs"]
        ),
        Document(
            id: "campus-facilities",
            content: "STAC's campus features modern facilities for academics, athletics, and student life. Academic buildings include state-of-the-art classrooms, laboratories, and computer facilities. The Spartan Athletic Complex includes a gymnasium, fitness center, and athletic fields. The Romano Student Center houses dining facilities, meeting spaces, and student organization offices. Residence halls offer comfortable living spaces with study lounges and recreational areas.",
            metadata: ["category": "campus", "type": "facilities"]
        ),
        Document(
            id: "student-support",
            content: "STAC provides comprehensive support services for student success. The Center for Academic Excellence offers tutoring, study skills workshops, and academic coaching. The Counseling Center provides mental health services and wellness programs. Disability Services ensures equal access to education for students with disabilities. The Office of Student Success helps with academic planning, time management, and goal setting.",
            metadata: ["category": "campus", "type": "support"]
        ),
        Document(
            id: "campus-events",
            content: "STAC hosts numerous events throughout the academic year. Academic events include guest lectures, research symposia, and academic conferences. Cultural events feature art exhibitions, musical performances, and theater productions. Social events include Homecoming, Spring Weekend, and cultural celebrations. Athletic events showcase Spartan teams in various sports. The college also hosts career fairs, networking events, and community service activities.",
            metadata: ["category": "campus", "type": "events"]
        ),
        Document(
            id: "financial-aid",
            content: "STAC offers various financial aid options to help students afford their education. Merit-based scholarships recognize academic achievement, leadership, and special talents. Need-based grants and loans are available through federal and state programs. Work-study opportunities provide on-campus employment. The Financial Aid Office helps students navigate the application process and explore all available options.",
            metadata: ["category": "admissions", "type": "financial aid"]
        ),
        Document(
            id: "academic-calendar",
            content: "STAC's academic calendar includes fall and spring semesters, with optional summer sessions. Important dates include registration periods, add/drop deadlines, and final exam weeks. The college observes major holidays and has scheduled breaks for Thanksgiving, winter, and spring. Academic deadlines for graduation applications and course withdrawals are clearly marked. The calendar also includes special events like orientation and commencement.",
            metadata: ["category": "academics", "type": "calendar"]
        ),
        Document(
            id: "library-resources",
            content: "The Lougheed Library provides extensive resources for research and study. The collection includes print books, e-books, academic journals, and multimedia materials. Research databases cover various academic disciplines. Interlibrary loan services provide access to materials from other libraries. The library offers study spaces, computer labs, and group study rooms. Librarians provide research assistance and information literacy instruction.",
            metadata: ["category": "campus", "type": "library"]
        ),
        Document(
            id: "technology-resources",
            content: "STAC provides comprehensive technology resources for students. Campus-wide WiFi ensures internet access throughout the college. Computer labs offer specialized software for various academic programs. The IT Help Desk provides technical support and assistance with device setup. Students have access to Microsoft Office 365, learning management systems, and academic software. The college maintains up-to-date technology in classrooms and labs.",
            metadata: ["category": "campus", "type": "technology"]
            
        ),
        Document(
            id: "student-life",
            content: "student-life can be found here you can connect them using social media and other platforms.",
            metadata: ["category": "student-life", "type": "social-media"]
        ),
        
    ]
    
    private init() {}
    
    // Vector representations would typically be computed using embeddings
    // For this demo, we use keyword matching as a simple retrieval method
    func retrieveRelevantDocuments(for query: String, limit: Int = 3) -> [Document] {
        let queryWords = query.lowercased().components(separatedBy: .whitespacesAndNewlines)
            .filter { !$0.isEmpty }
        
        // Calculate relevance scores for each document
        let scoredDocs = documents.map { doc -> (Document, Double) in
            let docWords = doc.content.lowercased().components(separatedBy: .whitespacesAndNewlines)
                .filter { !$0.isEmpty }
            
            // Simple relevance score based on word overlap
            var score = 0.0
            for queryWord in queryWords {
                if docWords.contains(where: { $0.contains(queryWord) }) {
                    score += 1.0
                }
            }
            
            // Check for category matches in metadata
            if let category = doc.metadata["category"], queryWords.contains(where: { category.contains($0) }) {
                score += 0.5
            }
            
            if let type = doc.metadata["type"], queryWords.contains(where: { type.contains($0) }) {
                score += 0.5
            }
            
            return (doc, score)
        }
        
        // Sort by relevance score and take top results
        let sortedDocs = scoredDocs.sorted { $0.1 > $1.1 }
        let topDocs = sortedDocs.prefix(limit).filter { $0.1 > 0 }.map { $0.0 }
        
        return Array(topDocs)
    }
    
    // Format retrieved documents into a prompt context
    func formatContextForPrompt(documents: [Document]) -> String {
        if documents.isEmpty {
            return "No specific information available about this query."
        }
        
        return """
        Here is some information about St. Thomas Aquinas College that might help answer the query:
        
        \(documents.map { "- " + $0.content }.joined(separator: "\n\n"))
        """
    }
}

// Document model for knowledge base entries
struct Document: Identifiable {
    let id: String
    let content: String
    let metadata: [String: String]
}
