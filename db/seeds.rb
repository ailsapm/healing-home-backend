# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)

#make sure there's a default admin user
default_user = User.find_or_create_by!(email: "admin@example.com") do |user|
  user.username = "Admin"
  user.password = "password"
  user.password_confirmation = "password"
  user.admin = true
end

#make a default course category if none exists
default_category = CourseCategory.first_or_create!(name: "General")

#helper method to add a course with lessons
def add_course(title, free, lessons, author, category)
  course = Course.find_or_create_by!(title: title) do |c|
    c.description = "#{title} course"
    c.requires_purchase = !free
    c.price = free ? 0 : 20
    c.author = author
    c.category = category
  end

  lessons.each_with_index do |(lesson_title, video_url), i|
    Lesson.find_or_create_by!(course: course, title: lesson_title) do |lesson|
      lesson.video_url = video_url
      lesson.lesson_order = i + 1
    end
  end
end

#seed the courses and lessons
add_course('Eat Your Weeds', true, [
  ['Nettles', 'https://vimeo.com/1100918662'],
  ['Plantain', 'https://vimeo.com/1100918673'],
  ['Self-heal', 'https://vimeo.com/1100919910']
], default_user, default_category)

add_course('Flower Power', true, [
  ['Goldenrod', 'https://vimeo.com/1100918630'],
  ['Musk Mallow', 'https://vimeo.com/1100918653'],
  ['Rose', 'https://vimeo.com/1100918692']
], default_user, default_category)

add_course('Mediterranean herbs', false, [
  ['Rosemary', 'https://vimeo.com/1100919889'],
  ['Sage', 'https://vimeo.com/1100919901'],
  ['Wild Marjoram', 'https://vimeo.com/1100919919']
], default_user, default_category)

add_course('Amazing leaves', false, [
  ['Raspberry leaf', 'https://vimeo.com/1100918681'],
  ['Blackberry leaf', 'https://vimeo.com/1100918619'],
  ['Mulberry leaf', 'https://vimeo.com/1100918642']
], default_user, default_category)


#seed blog posts
blog_posts = [
  {
    title: "What is Herbalism?",
    body: "<h3>A Brief Overview</h3><p>Herbalism is the study and practice of using herbs and plants to nourish the whole person and support overall well-being. Traditional forms of herbalism have been practiced around the world for thousands of years. Some well-known examples include:</p><ul><li><strong>Ayurveda:</strong> A traditional Indian system combining herbalism with diet, yoga, meditation, and more.</li><li><strong>Traditional Chinese Medicine:</strong> Incorporates herbs, mushrooms, acupuncture, and Qigong.</li><li><strong>Western Herbalism:</strong> A fusion of Indigenous North American and European practices.</li></ul><p>Other herbal traditions can be found in Africa, Asia, South America, and beyond.</p><h3>Herbalism Today</h3><p>Historically, herbal knowledge was passed down through generations. Today, herbalists learn through courses, apprenticeships, or university programs. There are many ways to practice:</p><ul><li><strong>Home Herbalist:</strong> Supports their own and their family's health, often self-taught or informally trained.</li><li><strong>Community Herbalist:</strong> May receive non-accredited training or apprenticeships and often works with the public.</li><li><strong>Clinical Herbalist:</strong> Formally trained to work with clients using evidence-based and traditional methods.</li><li><strong>Herbal Educator:</strong> Focuses on teaching herbal knowledge rather than clinical practice.</li><li><strong>Herbal Formulator:</strong> Creates herbal products for personal or commercial use.</li><li><strong>Herb Farmer or Grower:</strong> Grows herbs for markets, products, or personal practice.</li></ul>",
    image_url: "https://res.cloudinary.com/dwxz2audj/image/upload/v1746497421/mortar-pestle_zapwxa.jpg"
  },
  {
    title: "How to Brew Herbal Tea",
    body: "<h3>Brewing Herbal Teas</h3><h4>Brewing Basics</h4><p>Brewing herbal tea is an art that requires understanding the correct techniques to extract the best flavour and the most health benefits from your herbs. Here are some fundamental tips for brewing the perfect cup of herbal tea:</p><ul><li><strong>Water Quality:</strong> Use filtered water for the best flavour. Tap water can contain impurities that affect the taste of your tea.</li><li><strong>Water Temperature:</strong> Unlike traditional teas, most herbal teas require boiling water (around 212°F or 100°C). However, some delicate herbs might need somewhat cooler water to avoid bitterness.</li><li><strong>Steeping Time:</strong> Herbal teas usually need a longer steeping time than traditional teas. As a general guideline, steep your herbs for between 5–10 minutes to ensure maximum flavour and medicinal benefits.</li></ul><h4>Step-by-Step Brewing Guide</h4><p>Follow these steps to brew your herbal tea:</p><ul><li><strong>Measure Your Herbs:</strong> Use about 1–2 teaspoons of dried herbs per cup of water. Adjust the amount based on your taste preference and the strength of the herbs.</li><li><strong>Boil the Water:</strong> Heat the water to a rolling boil. If you’re using a kettle with temperature control, set it to 212°F (100°C).</li><li><strong>Prepare the Infuser:</strong> Place the measured herbs into an infuser or directly into your teapot if you plan to strain the tea later.</li><li><strong>Add Water:</strong> Pour the boiling water over the herbs in the infuser or teapot.</li><li><strong>Steep the Tea:</strong> Cover (to preserve those precious volatile oils) and let the tea steep for 5–10 minutes. Some herbs may benefit from longer steeping times; adjust based on the specific herbs you’re using.</li><li><strong>Strain and Serve:</strong> If you brewed the tea directly in the teapot, strain the herbs before serving. Otherwise, remove the infuser. Pour the tea into your cup and enjoy.</li></ul><h4>Tips for Perfect Tea</h4><p>To ensure you always brew the perfect cup of herbal tea, keep these tips in mind:</p><ul><li><strong>Experiment with Steeping Times:</strong> Different herbs may require different steeping times to bring out their best flavours. Start with the recommended time and adjust to your taste.</li><li><strong>Use Fresh Herbs:</strong> Freshness is key to a flavourful and medicinal tea. Ensure your herbs are stored properly and are not past their expiration date.</li><li><strong>Avoid Over-Steeping:</strong> While longer steeping can enhance flavour, over-steeping can sometimes lead to bitterness, especially with delicate herbs.</li></ul><h4>Enhancing Your Tea</h4><p>To further enhance your tea, consider adding:</p><ul><li><strong>Sweeteners:</strong> Honey, stevia, or agave syrup to add a touch of sweetness.</li><li><strong>Citrus:</strong> A slice of lemon or orange to brighten the flavor.</li><li><strong>Spices:</strong> Cinnamon, cardamom, or cloves to add warmth and complexity to your tea.</li></ul><p>Happy brewing!</p>",
    image_url: "https://res.cloudinary.com/dwxz2audj/image/upload/v1752540164/herbaltea_hdqmp4.jpg"
  },
  {
    title: "Amazing Dandelions",
    body: "<p>Often dismissed as a pesky weed, the humble dandelion (<em>Taraxacum officinale</em>) is actually a powerhouse of nutrition and natural healing. Used for centuries in traditional medicine, this bright yellow flower and its leaves, roots, and even sap offer a range of health benefits that are now being validated by modern science.</p>\n\n<h3>Nutritional Powerhouse</h3>\n\n<p>Dandelion greens are rich in vitamins A, C, and K, and are a great source of calcium, potassium, iron, and fiber. Just one cup of raw dandelion greens provides over 500% of your daily vitamin K needs—essential for bone health and blood clotting. They’re also low in calories, making them a smart addition to salads, smoothies, or sautés.</p>\n\n<h3>Natural Detoxifier</h3>\n\n<p>One of the most well-known traditional uses of dandelion root is as a liver tonic. It’s believed to stimulate bile production, helping the liver flush toxins more efficiently. Some research also suggests dandelion root may help support digestion and relieve mild constipation due to its mild diuretic and prebiotic properties.</p>\n\n<h3>Anti-Inflammatory and Antioxidant</h3>\n\n<p>Dandelion contains high levels of antioxidants, including polyphenols and beta-carotene, which help combat oxidative stress and reduce inflammation. These properties may help protect against chronic diseases such as heart disease and cancer.</p>\n\n<h3>Blood Sugar and Cholesterol Support</h3>\n\n<p>Emerging studies show promise in dandelion’s ability to support healthy blood sugar levels and lower cholesterol. Certain compounds in dandelion root and leaves may improve insulin sensitivity and reduce triglyceride levels, though more human research is needed.</p>\n\n<hr>\n\n<h3>How to Enjoy Dandelion Safely</h3>\n\n<p>Dandelion can be consumed in teas, tinctures, capsules, or fresh in food. However, make sure they’re harvested from clean, pesticide-free areas. If you’re on medications—especially diuretics or blood thinners—consult your doctor before adding dandelion to your routine.</p>\n\n<hr>\n\n<p>Next time you see a dandelion, don’t just think of it as a weed—think of it as wild wellness growing right under your feet.</p>\n",
    image_url: "https://res.cloudinary.com/dwxz2audj/image/upload/v1754424703/dandelionhead_iy0cc0.webp"
  },
  {
    title: "Traditional Medicine Systems of the World",
    body: "<p>Long before modern pharmaceuticals and hospitals, people around the world developed rich, complex systems of medicine rooted in observation, nature, and holistic healing. These traditional systems are still used today—sometimes on their own, sometimes alongside modern medicine. Let’s take a tour of some of the most influential and enduring healing traditions from across the globe.</p>\n\n<h3>Ayurveda</h3>\n<p>Originating in India over 3,000 years ago, Ayurveda is one of the world’s oldest holistic healing systems. It’s based on the idea that health comes from balancing the body’s energies, known as doshas—Vata, Pitta, and Kapha. Ayurveda uses a wide range of therapies, including diet, herbal remedies, yoga, massage, and meditation. Today, it's widely practiced in India and gaining popularity globally, especially in wellness and spa cultures.</p>\n\n<h3>Traditional Chinese Medicine (TCM)</h3>\n<p>TCM has its roots in ancient China, dating back over 2,500 years. It views the body as a system of energy (Qi) that flows through meridians, and illness is seen as a disruption in that flow. Techniques like acupuncture, herbal medicine, cupping, and tai chi are used to restore balance. TCM is still widely used in China and across Asia, and is increasingly integrated into complementary therapies around the world.</p>\n\n<h3>Unani Medicine</h3>\n<p>Unani medicine evolved from ancient Greek teachings and was later developed in the Islamic world. It focuses on maintaining health through the balance of four bodily humors: blood, phlegm, yellow bile, and black bile. Treatments often involve herbal medicines, dietary changes, and therapeutic techniques like cupping. Unani is officially practiced in countries like India, Pakistan, and parts of the Middle East.</p>\n\n<h3>Siddha Medicine</h3>\n<p>Developed in South India, particularly in Tamil Nadu, Siddha medicine is a close cousin of Ayurveda but distinct in its philosophy and remedies. It emphasizes the balance of three humors and makes extensive use of herbs, minerals, and spiritual practices. Though less globally known than Ayurveda, Siddha remains a respected system in parts of India and is backed by dedicated institutions and practitioners.</p>\n\n<h3>African Traditional Medicine</h3>\n<p>African traditional medicine isn’t one single system but a diverse set of healing practices passed down through generations across the continent. These systems often combine herbalism, spiritual healing, and community rituals. Illness is sometimes viewed as having both physical and spiritual causes. Traditional healers remain essential healthcare providers in many African communities, especially in rural areas.</p>\n\n<h3>Indigenous North American Healing</h3>\n<p>Indigenous peoples of North America have long practiced holistic healing that connects the physical, emotional, spiritual, and environmental aspects of health. Sweat lodges, smudging, herbal remedies, and ceremonial rituals are common methods. These traditions are still preserved and practiced within Native American and First Nations communities today, often in combination with modern medicine.</p>\n\n<h3>Tibetan Medicine (Sowa Rigpa)</h3>\n<p>Tibetan medicine, also known as Sowa Rigpa, blends elements of Ayurveda, TCM, and ancient Bon spiritual practices. It focuses on balancing three energies—Lung (wind), Tripa (bile), and Beken (phlegm)—to maintain health. Diagnosis involves pulse reading and detailed personal history. Sowa Rigpa is still widely practiced in Tibet, Bhutan, Mongolia, and parts of the Himalayas, and has received international recognition for its holistic approach.</p>\n\n<h3>Mongolian and Siberian Traditional Medicine</h3>\n<p>In Mongolia and Siberia, traditional medicine is deeply tied to shamanic beliefs and the natural environment. Illness is often thought to result from spiritual imbalance or soul loss. Treatments may include herbal remedies, rituals, and spiritual guidance. These practices are still alive today, often passed down orally, and sometimes integrated with Tibetan medicine in the region.</p>\n\n<h3>Jamu (Indonesian Traditional Medicine)</h3>\n<p>Jamu is a traditional Indonesian system that focuses on maintaining health through natural remedies made from spices, roots, and herbs like turmeric, ginger, and tamarind. Traditionally prepared as drinks or tonics, Jamu has long been a household remedy in Indonesia. Today, it’s also popular in wellness circles and beauty treatments, with modern brands packaging it for broader markets.</p>\n\n<h3>Kampo (Japanese Traditional Medicine)</h3>\n<p>Kampo medicine was adapted from ancient Chinese medicine and refined in Japan over the centuries. It focuses primarily on herbal formulas, many of which are standardized and approved by the Japanese health system. Kampo is still widely used in Japan today, often prescribed alongside modern treatments, making it a unique blend of traditional and modern healthcare.</p>\n\n<p>From forest herbs in Indonesia to pulse diagnosis in Tibet, these traditional systems offer a different perspective on what it means to be healthy—one that emphasizes balance, prevention, and harmony with nature. While not a replacement for modern medicine, these ancient practices continue to shape how we care for ourselves and each other across cultures.</p>\n",
    image_url: "https://res.cloudinary.com/dwxz2audj/image/upload/v1754425859/tradmed_tlyko7.jpg"
  },
  {
    title: "The Holy Trinity of Galangal, Ginger & Turmeric",
    body: "\n<p>For thousands of years, traditional medicine systems across Asia have turned to the roots of ginger, turmeric, and galangal for healing and nourishment. While they may look similar, each of these “rhizome cousins” has unique benefits that make them staples in both kitchens and medicine cabinets around the world.</p>\n\n<h3>Ginger: The Warming Digestive Aid</h3>\n<p>Ginger is perhaps the most well-known of the three. With its spicy kick and warming quality, it's been used in Ayurveda, Traditional Chinese Medicine (TCM), and folk remedies to support digestion, reduce nausea, and ease inflammation. Modern studies back this up—ginger has been shown to help with motion sickness, morning sickness, and even menstrual pain.</p>\n\n<p>It’s also a natural anti-inflammatory and antioxidant, making it a go-to remedy for colds, sore throats, and joint pain. Fresh ginger tea or grated ginger in cooking is a simple way to enjoy its health benefits daily.</p>\n\n<h3>Turmeric: The Golden Anti-Inflammatory</h3>\n<p>Turmeric is easily recognized by its bold yellow color, thanks to the active compound <em>curcumin</em>. Used in Ayurveda and Unani medicine for centuries, turmeric is famous for its powerful anti-inflammatory and antioxidant properties. It’s often used to support joint health, boost immunity, improve digestion, and even brighten the skin.</p>\n\n<p>Curcumin has been widely researched in modern medicine for its potential role in reducing inflammation linked to conditions like arthritis, heart disease, and even certain cancers. Just remember—pairing turmeric with black pepper (which contains piperine) increases curcumin absorption significantly.</p>\n\n<h3>Galangal: The Spicy, Energizing Root</h3>\n<p>Galangal is less familiar in the West but plays a key role in Southeast Asian cooking and traditional medicine. With its sharp, citrusy flavor and intense aroma, it’s used to warm the body, aid digestion, and fight infections. In traditional Indonesian Jamu medicine, galangal is often combined with turmeric and tamarind in tonics that support immunity and overall vitality.</p>\n\n<p>Galangal contains compounds like galangin that may have antibacterial, antifungal, and anti-inflammatory effects. It's a great addition to soups, teas, or broths—especially when you're feeling under the weather.</p>\n\n<h3>Rooted in Wellness</h3>\n<p>Whether used individually or combined, ginger, turmeric, and galangal offer a potent, natural way to support your health. They’re flavorful, versatile, and backed by both tradition and science. You can sip them in teas, cook them into meals, or blend them into wellness shots—however you take them, your body (and taste buds) will thank you.</p>\n\n<hr>\n\n<p><em>Always consult your healthcare provider before starting any new herbal supplements, especially if you're on medication or managing a health condition.</em></p>\n",
    image_url: "https://res.cloudinary.com/dwxz2audj/image/upload/v1754426256/gingturm_pgf3ni.jpg"
  },
  {
    title: "Small Seeds, Big Benefits: Fenugreek & Mustard Seeds",
    body: "\n<p>They may be small, but fenugreek and mustard seeds have played a big role in traditional healing practices for centuries. Commonly found in Indian kitchens and herbal medicine cabinets alike, these seeds are loaded with nutritional and medicinal benefits. Let’s explore what makes them so powerful—and how you can easily add them to your daily routine.</p>\n\n<h3>Fenugreek: The Balancing, Blood-Sugar-Friendly Seed</h3>\n<p>Fenugreek seeds have a slightly bitter, nutty flavor and a long history of use in Ayurveda and traditional Middle Eastern medicine. They're especially known for supporting digestion, balancing blood sugar, and boosting milk production in breastfeeding mothers. Rich in fiber, protein, and plant compounds like trigonelline and saponins, fenugreek is a go-to remedy for those managing metabolic conditions.</p>\n\n<p>Modern research has shown that fenugreek may help lower blood sugar levels, reduce appetite, and improve cholesterol. It’s commonly used as a tea, in spice blends like curry powder, or soaked overnight and consumed in the morning for digestive benefits.</p>\n\n<h3>Mustard Seeds: The Warming Circulatory Stimulant</h3>\n<p>Mustard seeds—black, brown, or yellow—pack a pungent punch and have been used medicinally in both Ayurveda and ancient Greek traditions. These tiny seeds stimulate circulation, warm the body, and can even help relieve muscle pain when used externally as a poultice or in a warm soak.</p>\n\n<p>Internally, mustard seeds are known to aid digestion and metabolism. They contain glucosinolates, compounds that are thought to have anti-inflammatory and even anti-cancer properties. In cooking, they’re often tempered in hot oil to release their flavor and health benefits—adding a subtle heat and depth to dishes like dals, curries, and pickles.</p>\n\n<h3>How to Use Them</h3>\n<p>Both fenugreek and mustard seeds are easy to incorporate into your daily meals. Toast them lightly in oil to bring out their flavor, add them to soups, spice blends, or herbal teas, or use ground versions in home remedies. Just a little goes a long way—these seeds are potent in both taste and therapeutic value.</p>\n\n<hr>\n\n<p><em>As with any herb or spice used therapeutically, it’s a good idea to consult a healthcare provider—especially if you’re pregnant, breastfeeding, or managing a medical condition.</em></p>\n",
    image_url: "https://res.cloudinary.com/dwxz2audj/image/upload/v1754426641/fenu-must_fj7zxz.jpg"
  }
]

blog_posts.each do |post_data|
  BlogPost.find_or_create_by!(title: post_data[:title]) do |post|
    post.body = post_data[:body]
    post.image_url = post_data[:image_url]
    post.user = default_user
  end
end


#seed plants
plants = [
  {
    common_name: "Thyme",
    scientific_name: "Thymus vulgaris",
    family: "Lamiaceae",
    description: "Garden Thyme (Thymus vulgaris) is a woody perennial herb native to southern Europe and the Mediterranean area. It has small, aromatic grey -green leaves and blooms in clusters of pink or lavender flowers from late spring through to early summer. It grows to between 6 to 12 inches in height and has a spread of 12 to 18 inches. The name 'vulgaris' means common, and refers to its widespread use and cultivation. Wild Thyme grows in an almost snakelike manner, which gave rise to its Latin name (Thymus serpyllum). It possesses similar medicinal properties to those of common garden Thyme, but is more subtle, gentler even. It is also known as 'Mother of Thyme'.",
    growing_harvesting: "Thyme thrives in well-draining, sandy, or rocky soils and prefers full sun. It is drought-tolerant and can withstand frost, making it suitable for various climates. When planting thyme, ensure it is spaced 12 to 24 inches apart to allow for its vigorous growth. Regular trimming helps maintain its shape and encourages new growth. Thyme can be propagated through stem cuttings, layering, or division, but it is challenging to grow from seeds due to uneven germination.\n\nOnce established, thyme plants can be harvested at any time, as the flavor of the herb is retained even after flowering. That being said, the flavor will be strongest just before the plant flowers, so that is typically the best time to make your cuttings. To harvest, simply snip a few stems any time the inspiration to cook with the herb hits. Do not harvest more than one-third of the plant at one time; generally, you'll get two to three crops out of a single plant per season.",
    photo_url: "https://res.cloudinary.com/dwxz2audj/image/upload/v1752539853/thyme_zaerlx.jpg",
    parts_used: "Aerial parts - they are best gathered while flowering.",
    physiological_actions: "Antiviral, Antimicrobial, Diaphoretic, Expectorant, Antispasmodic, Sedative, Antitussive, Bitter, Vermifuge, Diuretic",
    energetics: "Pungent, Slightly Bitter, Warming, Drying",
    ways_to_use: "Tincture, Tea, Capsule, Syrup, Poultice, Culinary, Infused into Oil/Honey/Vinegar, Thyme Salt, Essential Oil",
    uses: "Coughs, Bronchitis, Asthma, Respiratory health, Overall Immunity, Decongestant, Anti-inflammatory, Anti-aging effects (skin),  Dysmenorrhea (painful menstruation), Gut health, Digestion, IBS, Ulcers",
    cautions: "Generally considered safe and non-toxic. However there are rare cases of allergic reaction. For pregnant or breast-feeding women, and young children, it is always best to stick to whole-based thyme rather than medicinal preparations. Never take essential oil internally.",
    history: "Thyme was likely brought to northern Europe by the Romans. Roman soldiers believed that washing in thyme-scented water made them braver on the battlefield, and Roman politicians ate it before their meals as a protection against poisoning. Ancient Egyptians used it in their embalming process, and it was also used by the Greeks and Romans for purification and cleansing rituals. In the Middle Ages, thyme was used as a strewing herb to ward off evil spirits and protect against disease.",
    magical: "The souls of the dead were believed to live in thyme flowers, and people used to make a drink from thyme sprigs in order to commune with the dead. Thyme has been used for centuries as a way to induce prophetic dreams. The herb is said to open up the third eye and allow access to the subconscious mind. It has also been used traditionally as a smudge herb, to ward off evil spirits."
  },
  {
    common_name: "Catmint",
    scientific_name: "Nepeta mussinii",
    family: "Lamiaceae",
    description: "Catmint (Nepeta mussini) is a hardy perennial with aromatic blue grey foliage. It has attractive spikes of lavender blue flowers in Summer. The flowers are also particularly irresistible to bees and other pollinators. The tea is calming and sleep-inducing, and can be applied to bruises, especially black eyes, for faster healing.",
    growing_harvesting: "Catmint thrives in full sun and well-drained soil. It performs well in borders, edging, rock gardens, and pollinator-friendly spaces. Once established, it is highly drought-tolerant and copes well with challenging conditions.\n\nThe optimal time to harvest catmint is in late spring or early summer when the plant is in full bloom. This is when the essential oils that give catmint its distinctive scent and taste are at their highest concentration.",
    photo_url: "https://res.cloudinary.com/dwxz2audj/image/upload/v1753160077/catmint_bxkvol.avif",
    parts_used: "Aerial parts",
    physiological_actions: "Nervine, Carminitive, Antispasmodic, Diaphoretic, Decongestant, Antitussive, Stimulant",
    energetics: "Hot, Astringent",
    ways_to_use: "Tea, Tincture, Infusion, Culinary",
    uses: "Fevers, Colds, Digestion, Insect Repellent, Anxiety, Tension Headaches, Insomnia, Nightmares, Bruises",
    cautions: "None known",
    history: "The Romans used Catmint as pain relief and flavouring their food with it. It was used as an amulet to ward off evil spirits in the Middle Ages. Poultices were applied to the gums to ease toothache, to the sore breasts of nursing mothers and even to tackle the discomfort of piles. The Ancient Egyptians were supposedly the first to give it to their cats to delight them.",
    magical: "Catmint leaves are often pressed between the pages of magical texts and used as bookmarks. A common ingredient in love sachets mixed with Rose petals. Old lore has it that if you hold catmint in the palm of your hand until it is warm, then hold someone's hand, they will be a lifelong friend, provided you keep the catmint safe."
  },
  {
    common_name: "Rosemary",
    scientific_name: "Salvia rosmarinus",
    family: "Lamiaceae",
    description: "A fragrant evergreen herb native to the Mediterranean, used in cooking and medicine.",
    growing_harvesting: "Thrives in full sun and well-drained soil. Harvest sprigs as needed, ideally in the morning.",
    photo_url: "https://res.cloudinary.com/dwxz2audj/image/upload/v1748507661/rosemary_tclxqe.jpg",
    parts_used: "Leaves, flowering tops",
    physiological_actions: "Stimulant, circulatory tonic, antimicrobial",
    energetics: "Warming and drying",
    ways_to_use: "Infusion, tincture, essential oil, culinary",
    uses: "Memory support, headaches, muscle pain, digestive aid, liver tonic",
    cautions: "Avoid high doses in pregnancy; may increase blood pressure",
    history: "Used since ancient Greece for memory and remembrance rituals",
    magical: "Associated with protection, love, and remembrance"
  },
  {
    common_name: "Chickweed",
    scientific_name: "Stellaria media",
    family: "Caryophyllaceae",
    description: "Chickweed is an annual wildflower, producing a clump of floppy stems about 14 inches tall. The small, oval, pointed leaves are bright green and held opposite each other on the stem. In the evening, these fold together to protect the tender new growth. Tiny, white flowers with five divided petals arranged in a star shape are produced along the stems and in clusters at the tips throughout the year. Each flower only lasts a day or two before developing into a downward-hanging seedpod.",
    growing_harvesting: "It grows everywhere and doesn't take much encouragement to spread itself around your garden or veg patch. Chickweed is tastiest when grown in shade, in cool weather.\n\nCut or pinch off the last two to four inches of each stem; these are the tastiest and most tender parts of the plant. You can use scissors to quickly shear off the tops of your plants, leaving the rest behind to continue growing. You can also dry some to use later in the year.",
    photo_url: "https://res.cloudinary.com/dwxz2audj/image/upload/v1753160050/Chickweed_tl1vsk.jpg",
    parts_used: "Aerial parts",
    physiological_actions: "Demulcent, Anti-inflammatory, Antipruritic, Aperient, Expectorant",
    energetics: "Sweet, Salty, Astringent, Cooling, Moistening",
    ways_to_use: "Ointment, Juice, Poultice, Cream, Culinary, Decoction, Bath soak",
    uses: "Wound healing, Insect bites, Skin health, Digestion, Anti-inflammatory, Expectorant, Diuretic, Lymphatic System, Eczema, Tissue repair",
    cautions: "Generally considered safe. Use cautiously if you have a sensitive stomach - start with small dose and build up.",
    history: "Traditional salad ingredient - contains 12 times more calcium, 5 times more magnesium, 83 times more iron, and 6 times more vitamin C than spinach. Ancient Egyptians, Greeks, and Romans valued this herb for its healing properties, particularly for skin ailments and digestive issues. In European folk medicine, chickweed was commonly used to treat wounds, burns, and eye infections.",
    magical: "In European folklore and magic, chickweed was used to promote fidelity, attract love, and maintain relationships. A sprig of chickweed carried was used to draw the attention of a loved one or ensure the fidelity of one’s partner. Sailors used chickweed vinegar to prevent scurvy when fresh citrus was unavailable."
  },
  {
    common_name: "Sage",
    scientific_name: "Salvia officinalis",
    family: "Lamiaceae",
    description: "A shrubby, perennial herb native to the Mediterranean. It has grey-green leaves with a slightly fuzzy texture and a strong, aromatic scent.",
    growing_harvesting: "Prefers full sun and well-drained soil. Harvest leaves as needed, ideally before flowering for best flavor.",
    photo_url: "https://res.cloudinary.com/dwxz2audj/image/upload/v1748507676/sage_vgfjjg.jpg",
    parts_used: "Leaves",
    physiological_actions: "Antimicrobial, Astringent, Digestive, Anti-inflammatory",
    energetics: "Warm and dry",
    ways_to_use: "Tea, tincture, infusion, culinary",
    uses: "Sore throat, digestive issues, excessive sweating, memory support",
    cautions: "Avoid high doses during pregnancy and breastfeeding",
    history: "Known since ancient times for medicinal and culinary uses",
    magical: "Used for protection, wisdom, and purification rituals"
  },
    {
    common_name: "Dandelion",
    scientific_name: "Taraxacum officinale",
    family: "Asteraceae",
    description: "Dandelion may be distinguished from other similar-looking herbs by the hollow, leafless flower stems that contain a bitter milky-white liquid also found in the root and leaves. The dark green dandelion leaves, with their irregular, deeply jagged margins, have a distinctive hairless mid-rib. The leaves are arranged in a rosette pattern, and may grow to 1.5 ft (45.7 cm) in length. They have a magenta tint that extends up along the inner rib of the stalkless leaf.  Dandelion blossoms are singular and round, with compact golden-yellow petals. They bloom from early spring until well into autumn on top of hollow stalks that may reach from 4–8 inches in height. ",
    growing_harvesting: "The best time to sow dandelion are the months of March to the end of May, whereby it can also be sown in late summer from September to early October. The sowing in the spring should happen in the greenhouse or on the window sill, so that the plantlets can be prick out from the beginning of June in the garden bed or in a large pot. If seeded in late summer, the seeds can be sprinkled directly in the field.\n\nAs it needs light to germ, the seeds should only be pressed slightly into the ground. But covering with soil should be mandatory, do not just lay the seeds on the ground. If planting in the garden bed, a seed spacing of at least 30 x 30 cm (12 x 12 in) is recommended. When used properly, the seedlings usually appear after two to three weeks.\n\nYou can harvest the delicate leaves before flowering continuously and use them fresh, later dandelion becomes increasingly bitter. When collecting, be careful to avoid freshly fertilized meadows! Plants, which grow near busy roads, should not be eaten because of pollution. Likewise, the dandelion flowers are edible.\n\nThe picked leaves and flowers should preferably dry. The leaves are bound together in bundles and hung upside down in a shady and airy place. If this is not possible, the leaves can also be dried in a dehydrator at temperatures between 30 and 40 ° C.\n\nThe flowers are similar. Since they are bad to hang (the stalks with the milk juice should be removed), it is better to spread them out and dry in the air or in the dehydrator. This should go quickly, so that the flowers no longer have the opportunity to close.",
    photo_url: "https://res.cloudinary.com/dwxz2audj/image/upload/v1752539870/dandelion_ie5vt9.webp",
    parts_used: "Roots, Leaves, Flowers, Seedheads",
    physiological_actions: "Bitter, Diuretic, Alterative, Aperient, Blood-sugar balancer/hypoglycaemic, Cholagogue, Anti-inflammatory",
    energetics: "Bitter, Sweet, Cooling",
    ways_to_use: "Tea, Tincture, Infusion, Salve, Culinary, Decoction",
    uses: "Liver support, Digestion, Blood Sugar Regulation, Diuretic, Anti-inflammatory, Immune Support, Culinary, Detoxification, Pain Relief, Blood Cleanser, Cholesterol Regulation, Bone health, Urinary health",
    cautions: "Dandelion is generally considered safe, especially if taken as a food.  However there are certain things to watch out for:\n\nDiabetics on insulin or Hypoglycemics should be cautious in the use of dandelion root extract as it can lower blood sugar significantly. Dandelion leaves contain oxalates which could cause problems for people with kidney disease. Dandelion root contains compounds that may cause uterine contractions so best avoided during pregnancy. Anyone with allergies to ragweed, or any member of the Asteraceae family, might encounter sensitivities. Anyone with gallbladder or bile duct issues should exercise caution as dandelion root stimulates bile production. Also be aware of drug interactions for anyone on Lithium, Diuretics or Blood Thinners. As with all herbal medicine, taking it as a food source rather than an extract is generally safer and better tolerated.",
    history: "Dandelion's common name is derived from the French dent de lion, lion's tooth, a reference to the irregular and jagged margins of the lance-shaped leaves. The history of dandelions can be traced back thousands of years, with evidence of their use in traditional medicine found in ancient Chinese, Roman and Arabic texts. The medicinal uses of dandelions were first documented in the 10th century, and by the 17th century, usage of the plant as a natural remedy had spread across Europe and North America via colonists who valued dandelions' medicinal properties.",
    magical: "In medieval Europe, dandelions were considered a symbol of resilience and adaptability, often depicted in art and literature. In some cultures, blowing on a dandelion clock (the white, fluffy seed head) and making a wish before the seeds disperse is a cherished childhood tradition."
  },
  {
    common_name: "Yarrow",
    scientific_name: "Achillea millefolium",
    family: "Asteraceae",
    description: "Perennial plant reaches a height of up to 3.5 feet; has fernlike, finely dissected leaves; and its flat or slightly convex flower heads, blooming from spring well into autumn, consist of clusters of small flowers. In the wild, its flowers range in colour from white to pink. It has a distinctive, pungent scent.",
    growing_harvesting: "Yarrow is very quick to establish and spread. It is most commonly propagated by seed, root division, or cutting in the early spring or late autumn. Pretty as lace and tough as nails, yarrow is one of the easiest plants to grow in your garden. As long as you give yarrow the environment it wants, you’ll likely never have to tend to it again.\n\nIt is best to harvest yarrow on a warm, sunny day when the plants are in full bloom. Wait until the dew has dried, but before the plants' essential oils have dissipated in the heat of the day. Cut the stem just above a leaf node. You can use both the flowers and the leaves",
    photo_url: "https://res.cloudinary.com/dwxz2audj/image/upload/v1754586503/yarriw_qf9et3.jpg",
    parts_used: "Aerial parts, especially flowers, Roots",
    physiological_actions: "Styptic, Peripheral Circulatory Stimulant, Diaphoretic, Diuretic, Emmenagogue, Bitter, Anti-inflammatory, Antispasmodic",
    energetics: "Bitter, Cooling, Stimulating, Protective, Clearing",
    ways_to_use: "Tea, Tincture, Poultice, Capsules, Infusion, ",
    uses: "Fevers, Cold, Flu Relief, Digestion, Menstrual Pain, Wound Healing, Anxiety, Blood Pressure, Liver Health, Kidney Issues, Malaria, Skin Health",
    cautions: "If foraging for this herb make sure you identify it correctly. There are many lookalikes and some of them are poisonous. If in doubt, do not use. ",
    history: "Yarrow has long been valued for its ability to stop bleeding (hemostatic), relieve pain (analgesic), and prevent infection (antiseptic). In ancient Greek and Roman medicine, it was a common remedy for treating wounds, reducing inflammation, and controlling bleeding. Many Native American tribes also used yarrow for a range of health issues, including injuries, burns, and digestive problems.  It has traditionally been used in cheesemaking as a natural plant-based substitute for rennet.\n\nThe  Latin name Achillea millefolium is said to be associated with the Greek warrior, Achilles. The story reports that Achilles was gifted Yarrow plants from Chiron, the wise centaur,  who told him to use the flowering tops to stop the excessive bleeding in his wounded soldiers during battle. It is said that when Achilles was born, his mother held him by the heel and dipped him in a bath of Yarrow tea to protect him from harm. Achilles died from a arrow to his achilles heel, where the yarrow tea did not touch. The species name “millefolium” means “thousand-leaved,” referring to the finely divided, feathery leaves of the plant.",
    magical: "Yarrow protects against evil and harm. When held in the hand it prevents fear. You can burn dried Yarrow along with other herbs such as Sage to cleanse spaces,  or hang it above doorways along with Sweetgrass (Hierochloe odorata) to ward off evil spirits."
  },
  {
    common_name: "Boneset",
    scientific_name: "Eupatorium perfoliatum",
    family: "Asteraceae",
    description: "A perennial, grows up to 39 inches tall, with opposite, serrate leaves that clasp the stems (perfoliate). The stem is hairy and the plant produces dense clusters of tiny white flower heads held above the foliage. ",
    growing_harvesting: "Boneset thrives in full sun to partial shade with moist, well-draining soil. Aerial parts should be harvested when the plant is flowering.",
    photo_url: "https://res.cloudinary.com/dwxz2audj/image/upload/v1753159967/boneset_l2c1fi.jpg",
    parts_used: "Aerial parts",
    physiological_actions: "Diaphoretic, Tonic, Expectorant, Bitter, Cholagogue, Aperient, Emetic",
    energetics: "Bitter, Hot, Light, Dry",
    ways_to_use: "Tea, Tincture",
    uses: "Fevers, Digestion, Antimicrobial, Flu, Cold, Anti-parasitic, Laxative, Anti-viral",
    cautions: "Less is more! This is a very potent herb and too much can cause nausea and even harm. Exercise extreme caution. For internal use, a weak tea is  best, as little as half a teaspoon of dried herb to a pint of boiling water. Steep for a few minutes, remove herb and leave tea to cool before sipping in SMALL amounts. If you start to feel nauseated that is your body telling you that you have had enough. If you don't wish to take internally, you can use the tea as a body wash or foot soak to help break a fever. ",
    history: "Boneset was historically used in traditional medicine to help relieve symptoms of influenza, fevers, body aches, and the common cold. Its name purportedly comes from its historical use in treating breakbone fever (dengue fever), due to its reputed ability to ease intense body pain. Native American communities also used boneset to address a range of health concerns, such as respiratory infections, digestive problems, and arthritis.",
    magical: "Boneset is often used for protection and banishing spells. Its strong, hardy energy is believed to ward off negative influences and harmful entities, making it a powerful herb for clearing spaces of unwanted energy. Burning dried Boneset as incense or placing it around your home can cleanse the space and keep negative energy at bay. Boneset is often used to bolster inner strength and fortify the spirit, helping you endure challenges and hardships with grace. Add dried Boneset to your bathwater for a healing and cleansing ritual. Create a healing sachet by placing dried Boneset in a small pouch with other healing herbs, such as rosemary or lavender. Carry the sachet with you or place it under your pillow to promote emotional and spiritual healing."
  },
  {
    common_name: "Cowslip",
    scientific_name: "Primula veris",
    family: "Primulaceae",
    description: "The cowslip displays a rosette of green, crinkly, tongue-like leaves, low to the ground. Its tube-like, egg-yolk-yellow flowers are clustered together at the ends of its upright, green stems.",
    growing_harvesting: "It grows well in shady areas and places with full direct sunlight, as long as the soil is sufficiently moist.  Roots provide the best medicine but never harvest the roots of cowslips in the wild, they are in decline and need to be protected. Much better to grow your own and harvest them judiciously. Flowers are more sustainable to harvest and are also a good source of medicine.",
    photo_url: "https://res.cloudinary.com/dwxz2audj/image/upload/v1753160716/cowslip_cafzko.jpg",
    parts_used: "Roots, Flowers",
    physiological_actions: "Sedative, Antispasmodic, Expectorant, Antitussive, Anti-inflammatory",
    energetics: "Cooling, Moist",
    ways_to_use: "Tea, Culinary, Infusion, Powder (from the dried flowers)",
    uses: "When used on the skin in waters and lotions, its unique cleansing properties are said to remove dirt and open the pores of the skin. It has been used for centuries to make sedative tea. Its leaves are said to be mildly narcotic, and it is used as an herbal remedy for insomnia as well as hyperactivity.\nIt has historically been used as an effective calming tea for issues related to nerves and anxiety. The flowers are thought to be a milder sedative and have been used to calm children and help them sleep.  Cowslip roots are expectorant and can be used to treat the common cold and flu-like symptoms. They help break up mucus so that it can be more easily expelled by the body. Cowslip has been used in folk remedies to reduce blood clotting and is sometimes used as an antirheumatic. An infusion of cowslip root in honey (left to infuse for at least 3-4 weeks) can be used to help all kinds of throat and chest infections.",
    cautions: "Cowslip contains high levels of salicylates and is not recommended for anyone with a known allergy to aspirin. It should also not be used by anyone who is undergoing anticoagulant treatment or by pregnant women. Breastfeeding mothers however, can use it as it is supposed to stimulate lactation.",
    history: "The cowslip has many folk names due to its historical importance and fame, including 'key of heaven', 'paigles', 'bunch of keys' and 'herb Peter'. The name cowslip actually means 'cow-slop' (i.e. cowpat), in reference to its choice of meadow habitat.  The nodding flowers suggests the bunch of keys which were the badge of St. Peter. One legend is that Peter was told that a duplicate key to Heaven had been made and therefore let his keys drop. The Cowslip broke from the ground where the keys fell.  It was traditionally strewn on church paths for early springtime weddings and used to make  garlands for May Day.",
    magical: "The cowslip is associated with love, healing, and fertility. It is believed to protect against evil spirits and to bring good luck and happiness to those who grow it. In folklore, cowslip flowers were thought to be the keys to the fairy kingdom and were used in charms and spells to attract love and prosperity."
  }

]

plants.each do |plant_data|
  Plant.find_or_create_by!(common_name: plant_data[:common_name]) do |plant|
    plant.scientific_name = plant_data[:scientific_name]
    plant.family = plant_data[:family]
    plant.description = plant_data[:description]
    plant.growing_harvesting = plant_data[:growing_harvesting]
    plant.photo_url = plant_data[:photo_url]
    plant.parts_used = plant_data[:parts_used]
    plant.physiological_actions = plant_data[:physiological_actions]
    plant.energetics = plant_data[:energetics]
    plant.ways_to_use = plant_data[:ways_to_use]
    plant.uses = plant_data[:uses]
    plant.cautions = plant_data[:cautions]
    plant.history = plant_data[:history]
    plant.magical = plant_data[:magical]
  end
end


#seed recipes 
recipes = [
  {
    title: "Thyme syrup",
    description: "A great medicine for coughs and colds",
    ingredients: "I cup strong Thyme tea, I cup honey",
    instructions: "Pour Thyme tea over honey, stir to combine well, add to bottle. Shake frequently. Refrigerate and use within one month.",
    image_url: "https://res.cloudinary.com/dwxz2audj/image/upload/v1754413438/thymesyrup_ng5b2i.jpg",
    user: default_user,
    is_remedy: true,
    tags: ["syrup", "colds", "coughs", "sore throat"]
  },
  {
    title: "Rosemary Infusion",
    description: "A soothing herbal tea made with fresh or dried rosemary, good for digestion, memory and liver.",
    ingredients: "4 cups boiling water\n1/2 cup fresh rosemary (or 1/4 cup dried)",
    instructions: "Chop the rosemary finely to expose more surface area. Place in a teapot or mason jar and pour over boiling water. Cover and steep for 10-15 minutes. Strain and compost the herbs. Drink within a day. For acute issues, drink 1/4 to 1/2 cup every 30 minutes. \nRosemary infusion is useful for coughs, indigestion, gastroenteritis, menstrual pain, bronchitis and cystitis. It is antibiotic, anti-inflammatory and a liver tonic.",
    image_url: "https://res.cloudinary.com/dwxz2audj/image/upload/v1752892204/rosemary-tea_p9nz6v.jpg",
    user: default_user,
    is_remedy: true,
    tags: ["tea", "digestion", "liver tonic", "herbal infusion"]
  },
  {
    title: "Catmint Jelly",
    description: "A fun, healthy treat that can soothe frazzled nerves and ease insomnia",
    ingredients: "Strong infusion of catmint, 1 pack of your favourite flavoured jelly or gelatine leaves",
    instructions: "Make a strong tea of catmint leaves and flowers, using 1/2 cup of fresh herb or 1/4 cup dried herb to 4 cups of hot (not boiling) water, leave to infuse for at least 10 minutes. Strain and use the resulting liquid in place of plain water to make a batch of jelly. Pour into ice cube tray, allow to set. Store in fridge and have one or two daily as a healthy, calming treat. You can also layer different colours of jelly for a fancier look. This method can be used for many other kinds of herbs too. ",
    image_url: "https://res.cloudinary.com/dwxz2audj/image/upload/v1754423759/herbaljelly_sfvxrk.jpg",
    user: default_user,
    is_remedy: true,
    tags: ["dessert", "insomnia", "anxiety", "calming"]
  },
  {
    title: "Dandelion Root Decoction",
    description: "This preparation uses the roots of the dandelion.  Prepared this way, the root is a great liver tonic, reducing inflammation and congestion.",
    ingredients: "Fresh or dried dandelion roots, water",
    instructions: "A decoction is essentially a strong tea. Tougher plant material such as dandelion roots require a longer simmer time to extract their benefits, unlike the delicate leaves that give up their goodness in just a few minutes.  Place one ounce of dried roots or two ounces fresh roots (by weight) in a pan with one pint of water. Bring to a boil, cover, and simmer for 20 minutes. Strain and compost the spent roots. Sip the decoction in small amounts, as too much can have a laxative effect!",
    image_url: "https://res.cloudinary.com/dwxz2audj/image/upload/v1754585872/dandelinoroot_amfre7.webp",
    user: default_user,
    is_remedy: true,
    tags: ["blood sugar", "cholesterol", "kidney health", "liver tonic", "herbal decoction"]
  },
  {
    title: "Thyme tea",
    description: "A soothing herbal tea to chase away flu and cold.",
    ingredients: "1 tsp dried thyme, 1 cup boiling water - or for larger amounts, 4 cups boiling water to 1/4 cup dried or 1/2 cup fresh thyme",
    instructions: "Pour boiling water over herb and cover, leave for 10-15 minutes for full potency. Have up to five cups daily in case of illness, or sip a cup a day for health measures.",
    image_url: "https://res.cloudinary.com/dwxz2audj/image/upload/v1754410703/thymetea_vecyyg.jpg",
    user: default_user,
    is_remedy: true,
    tags: ["tea", "colds", "coughs", "herbal infusion"]
  },
  {
    title: "Yarrow First Aid Salve",
    description: "An invaluable addition to your first aid kit, it can treat all kinds of skin issues and emergencies.",
    ingredients: "Dried yarrow leaves and/or flowers, Carrier oil (such as olive/jojoba/sweet almond/pumpkin seed or a blend of several, beeswax (yellow or white) - pellets are easy to measure.",
    instructions: "First make a yarrow-infused oil. Fill a clean jar halfway with dried yarrow, then fill jar with your chosen carrier oil. Put a lid on and leave to infuse in a cool, dark place for  4-6 weeks or up to 6 months for stronger potency. Once the oil is infused and ready to use, strain the dried yarrow plant material from the oil using a sieve lined with muslin cloth - be sure to squeeze it well to get the most goodness from your plant. The oil can be used as it for skincare and as a bath oil, it will keep well if stored in a cool dark place for up to 2 years. \nTo make the salve, warm 1/2 cup of infused oil in a double boiler, add in 1/2 cup of beeswax pellets and stir gently to dissolve. Once fully combined remove from heat. You can add a few drops of essential oils at this stage (optional) - lavender or tea tree are good additions. Working quickly, pour the warm liquid into jars, tins or lip balm tubes and leave to set. Use within one year. \n\nThis salve can treat burns, wounds, scrapes and scratches. It  slows bleeding and speeds up the healing process. Yarrow salve is also wonderful for skin care. Use it on any dry skin, including severely dry and cracked skin caused by natural or chemical elements. It will moisturize extremely dry and flaky areas, as well as help heal irritation caused by dry weather. Soothing and astringent, use the yarrow salve anywhere your skin needs a little help. People with sensitivities to other plants in the Asteraceae family might experience a skin allergy, if that happens, discontinue use.\nThis is quite a hard-set salve which works well for first aid treatments, but if you prefer a softer salve, you can use 1/4 cup beeswax instead.",
    image_url: "https://res.cloudinary.com/dwxz2audj/image/upload/v1754591054/yarrowsalve_1_lhmfa4.webp",
    user: default_user,
    is_remedy: true,
    tags: ["salve", "burns", "bruises", "wounds", "skin issues", "dry skin"]
  },
  {
    title: "Chickweed poultice",
    description: "A quick, easy and effective way to treat bites, bruises, skin infections and even hot spots on animals. ",
    ingredients: "One handful of freshly harvested chickweed, or a couple of teaspoons of dried herb macerated with a little water with a mortar and pestle to blend into smooth paste",
    instructions: "Chop the chickweed finely or macerate with mortar and pestle, apply directly to affected skin. Wrap in muslin cloth and leave for up to 30 minutes or until itching subsides. Use it on insect bites and itchy skin. Also good for reducing swelling and for treating bruises. Great, natural treatment for hot spots on animals. Can help draw out infections from abscesses, boils, cuts and troublesome wounds. ",
    image_url: "https://res.cloudinary.com/dwxz2audj/image/upload/v1754417125/poultice_bgc7tm.webp",
    user: default_user,
    is_remedy: true,
    tags: ["bruises", "insect bites", "boils", "hot spots"]
  },
  {
    title: "Chickweed pesto",
    description: "A bright, zesty alternative to traditional basil pesto, this vitamin-filled delight is sure to put a spring in your step. Great overall health tonic.",
    ingredients: "1/2 cup olive oil, 1 cup of chickweed (or more), Small handful of garlic mustard or 2 cloves garlic, Walnuts or pine nuts, Salt and pepper (to taste), 2 tbsp Parmesan cheese",
    instructions: "Blend all ingredients well using a mortar and pestle until well combined. Spread on bread or crackers, stir through pasta or rice, use as a dip or marinade.",
    image_url: "https://res.cloudinary.com/dwxz2audj/image/upload/v1754419858/pesto-jar_l803hx.jpg",
    user: default_user,
    is_remedy: true,
    tags: ["tonic", "immune support", "energy", "vitamins"]
  },
  {
    title: "Sage Tea",
    description: "A calming herbal tea made from fresh or dried sage leaves, traditionally used to ease sore throats and menopausal symptoms.",
    ingredients: "4 cups boiling water\n1/2 cup fresh sage leaves (or 1/4 cup dried)",
    instructions: "Place the sage leaves in a teapot or jar and pour boiling water over them. Cover and steep for 10-15 minutes. Strain and discard the leaves. Drink within a day. For acute symptoms like sore throat, sip 1/4 to 1/2 cup every 30 minutes. Sage tea is antimicrobial, anti-inflammatory, and can help soothe throat irritation, support digestion, and relieve excessive sweating. Excellent support for symptoms of menopause such as hot flashes and night sweats.",
    image_url: "https://res.cloudinary.com/dwxz2audj/image/upload/v1752879680/sagetea_qj0ymd.jpg",
    user: default_user,
    is_remedy: true,
    tags: ["tea", "sore throat", "coughs", "herbal infusion"]
  }
]

recipes.each do |data|
  recipe = Recipe.create!(
    title: data[:title],
    description: data[:description],
    ingredients: data[:ingredients],
    instructions: data[:instructions],
    image_url: data[:image_url],
    user: data[:user],
    is_remedy: data[:is_remedy]
  )

  data[:tags].each do |tag_name|
    tag = Tag.find_or_create_by!(name: tag_name)
    recipe.tags << tag unless recipe.tags.include?(tag)
  end
end

