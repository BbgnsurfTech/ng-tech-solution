#!/usr/bin/env python3
"""
AgroConnect360 - Partner & Supplier Stakeholder Presentation
Creates a presentation focused on partnership opportunities and mutual benefits
"""

from pptx import Presentation
from pptx.util import Inches, Pt
from pptx.enum.text import PP_ALIGN
from pptx.dml.color import RGBColor

def create_partner_presentation():
    """Create a partner/supplier stakeholder presentation"""

    prs = Presentation()
    prs.slide_width = Inches(10)
    prs.slide_height = Inches(7.5)

    # Define color scheme
    PRIMARY_GREEN = RGBColor(46, 125, 50)
    SECONDARY_ORANGE = RGBColor(245, 124, 0)
    ACCENT_TEAL = RGBColor(0, 137, 123)
    WHITE = RGBColor(255, 255, 255)
    DARK_GRAY = RGBColor(33, 33, 33)

    def add_title_slide(title, subtitle=""):
        slide = prs.slides.add_slide(prs.slide_layouts[6])
        background = slide.background
        fill = background.fill
        fill.solid()
        fill.fore_color.rgb = PRIMARY_GREEN

        title_box = slide.shapes.add_textbox(Inches(0.5), Inches(2.5), Inches(9), Inches(1))
        title_frame = title_box.text_frame
        title_frame.text = title
        title_para = title_frame.paragraphs[0]
        title_para.font.size = Pt(54)
        title_para.font.bold = True
        title_para.font.color.rgb = WHITE
        title_para.alignment = PP_ALIGN.CENTER

        if subtitle:
            subtitle_box = slide.shapes.add_textbox(Inches(0.5), Inches(3.7), Inches(9), Inches(0.8))
            subtitle_frame = subtitle_box.text_frame
            subtitle_frame.text = subtitle
            subtitle_para = subtitle_frame.paragraphs[0]
            subtitle_para.font.size = Pt(28)
            subtitle_para.font.color.rgb = WHITE
            subtitle_para.alignment = PP_ALIGN.CENTER

        return slide

    def add_content_slide(title, content_items, use_bullets=True):
        slide = prs.slides.add_slide(prs.slide_layouts[6])

        title_shape = slide.shapes.add_textbox(Inches(0), Inches(0), Inches(10), Inches(1))
        title_shape.fill.solid()
        title_shape.fill.fore_color.rgb = PRIMARY_GREEN
        title_frame = title_shape.text_frame
        title_frame.text = title
        title_frame.paragraphs[0].font.size = Pt(36)
        title_frame.paragraphs[0].font.bold = True
        title_frame.paragraphs[0].font.color.rgb = WHITE
        title_frame.margin_left = Inches(0.5)
        title_frame.margin_top = Inches(0.2)

        content_box = slide.shapes.add_textbox(Inches(0.5), Inches(1.3), Inches(9), Inches(5.7))
        text_frame = content_box.text_frame
        text_frame.word_wrap = True

        for i, item in enumerate(content_items):
            if i > 0:
                text_frame.add_paragraph()
            p = text_frame.paragraphs[i]
            p.text = item
            p.font.size = Pt(20)
            p.font.color.rgb = DARK_GRAY
            p.space_after = Pt(12)
            if use_bullets:
                p.level = 0

        return slide

    def add_two_column_slide(title, left_content, right_content):
        slide = prs.slides.add_slide(prs.slide_layouts[6])

        title_shape = slide.shapes.add_textbox(Inches(0), Inches(0), Inches(10), Inches(1))
        title_shape.fill.solid()
        title_shape.fill.fore_color.rgb = PRIMARY_GREEN
        title_frame = title_shape.text_frame
        title_frame.text = title
        title_frame.paragraphs[0].font.size = Pt(36)
        title_frame.paragraphs[0].font.bold = True
        title_frame.paragraphs[0].font.color.rgb = WHITE
        title_frame.margin_left = Inches(0.5)
        title_frame.margin_top = Inches(0.2)

        left_box = slide.shapes.add_textbox(Inches(0.5), Inches(1.3), Inches(4.25), Inches(5.7))
        left_frame = left_box.text_frame
        left_frame.word_wrap = True
        for i, item in enumerate(left_content):
            if i > 0:
                left_frame.add_paragraph()
            p = left_frame.paragraphs[i]
            p.text = item
            p.font.size = Pt(18)
            p.font.color.rgb = DARK_GRAY
            p.space_after = Pt(10)

        right_box = slide.shapes.add_textbox(Inches(5.25), Inches(1.3), Inches(4.25), Inches(5.7))
        right_frame = right_box.text_frame
        right_frame.word_wrap = True
        for i, item in enumerate(right_content):
            if i > 0:
                right_frame.add_paragraph()
            p = right_frame.paragraphs[i]
            p.text = item
            p.font.size = Pt(18)
            p.font.color.rgb = DARK_GRAY
            p.space_after = Pt(10)

        return slide

    # Slide 1: Title
    add_title_slide(
        "AgroConnect360",
        "Strategic Partnership Opportunities"
    )

    # Slide 2: Introduction
    add_content_slide(
        "Partnering for Mutual Growth 🤝",
        [
            "AgroConnect360 is Nigeria's leading agriculture value chain platform, connecting 350,000+ farmers with quality inputs, markets, and financial services.",
            "",
            "🎯 OUR VISION: Create Africa's most comprehensive agriculture ecosystem",
            "",
            "📈 GROWTH TRAJECTORY:",
            "  • 25,000 farmers by Year 1",
            "  • 350,000 farmers by Year 3",
            "  • ₦5 billion annual GMV by Year 3",
            "",
            "🤝 PARTNERSHIP APPROACH: Win-win collaborations that create value for all stakeholders"
        ],
        use_bullets=False
    )

    # Slide 3: Partner Ecosystem
    add_content_slide(
        "Our Partner Ecosystem",
        [
            "🌱 INPUT SUPPLIERS (Seeds, Fertilizers, Agrochemicals):",
            "  • Reach farmers directly without multiple middlemen",
            "",
            "🚜 EQUIPMENT MANUFACTURERS & DEALERS:",
            "  • Digital marketplace for tractors, tools, irrigation systems",
            "",
            "🏦 FINANCIAL INSTITUTIONS (Banks, MFIs, Insurance):",
            "  • Embedded lending and insurance products",
            "",
            "🏭 OFFTAKERS & PROCESSORS:",
            "  • Direct sourcing from verified farmer network",
            "",
            "🚚 LOGISTICS & DELIVERY SERVICES:",
            "  • Last-mile delivery to rural farmers"
        ],
        use_bullets=False
    )

    # Slide 4: Why Partner With Us
    add_content_slide(
        "Why Partner with AgroConnect360?",
        [
            "🎯 ACCESS TO 350K+ FARMERS: Direct channel to Nigeria's largest farmer network",
            "",
            "📱 DIGITAL DISTRIBUTION: Lower distribution costs, higher margins",
            "",
            "💳 SEAMLESS PAYMENTS: Integrated payment and financing solutions",
            "",
            "📊 DATA INSIGHTS: Customer behavior, preferences, and demand forecasting",
            "",
            "🤝 TRUSTED BRAND: Farmers trust our recommendations and verified partners",
            "",
            "🚀 RAPID SCALE: Grow your business as we expand across West Africa",
            "",
            "💰 REVENUE GROWTH: Partners see 40-60% increase in sales through our platform"
        ],
        use_bullets=False
    )

    # Slide 5: Partnership Models
    add_two_column_slide(
        "Flexible Partnership Models",
        [
            "🛒 MARKETPLACE PARTNERSHIP:",
            "• List your products on our platform",
            "• Revenue share: 85% partner / 15% platform",
            "• Access to marketing and customer support",
            "",
            "🤝 STRATEGIC PARTNERSHIP:",
            "• Co-branded solutions",
            "• Exclusive product offerings",
            "• Joint marketing campaigns",
        ],
        [
            "💰 FINANCIAL PARTNERSHIP:",
            "• Co-lending arrangements",
            "• Risk-sharing models",
            "• Embedded insurance products",
            "",
            "📊 DATA PARTNERSHIP:",
            "• Market intelligence sharing",
            "• Demand forecasting",
            "• Product development insights"
        ]
    )

    # Slide 6: Input Suppliers Partnership
    add_content_slide(
        "Input Suppliers: Reach Farmers Directly 🌱",
        [
            "💼 BENEFITS FOR YOU:",
            "  • Direct access to 350K+ farmers (eliminates 3-4 middlemen)",
            "  • 30-40% cost reduction in distribution",
            "  • Real-time inventory management and demand insights",
            "  • Guaranteed payments through escrow system",
            "",
            "👨‍🌾 VALUE FOR FARMERS:",
            "  • 20-30% lower prices on quality inputs",
            "  • Verified, genuine products (no counterfeits)",
            "  • Convenient delivery to farm gate",
            "  • Financing options for input purchases",
            "",
            "📈 EXPECTED RESULTS: 50-70% sales increase in Year 1"
        ],
        use_bullets=False
    )

    # Slide 7: Financial Institutions Partnership
    add_content_slide(
        "Financial Institutions: Expand Agricultural Lending 🏦",
        [
            "💼 BENEFITS FOR YOU:",
            "  • Access to 350K+ creditworthy, verified farmers",
            "  • Reduced customer acquisition cost (60% lower than traditional)",
            "  • Digital KYC and credit scoring infrastructure",
            "  • Lower default rates through data-driven risk assessment",
            "  • Portfolio diversification into high-growth agriculture sector",
            "",
            "👨‍🌾 VALUE FOR FARMERS:",
            "  • Fast loan approvals (24-48 hours vs. 2-3 weeks)",
            "  • Lower interest rates (15% vs. 25-30% informal)",
            "  • Flexible repayment aligned with harvest cycles",
            "",
            "📊 LOAN PERFORMANCE: <5% NPL rate (vs. 15% industry average)"
        ],
        use_bullets=False
    )

    # Slide 8: Offtakers Partnership
    add_content_slide(
        "Offtakers & Processors: Source Quality Produce 🏭",
        [
            "💼 BENEFITS FOR YOU:",
            "  • Guaranteed supply from 350K+ farmers",
            "  • Quality assurance and traceability systems",
            "  • Eliminate sourcing agents and aggregators",
            "  • Forward contracting for production planning",
            "  • 25-35% reduction in procurement costs",
            "",
            "👨‍🌾 VALUE FOR FARMERS:",
            "  • Guaranteed offtake agreements before planting",
            "  • Fair, transparent pricing",
            "  • Advance payments and input support",
            "",
            "🎯 COMMODITIES: Cocoa, cashew, cassava, rice, maize, yam, vegetables"
        ],
        use_bullets=False
    )

    # Slide 9: Integration & Onboarding
    add_content_slide(
        "Easy Integration & Onboarding",
        [
            "📱 PLATFORM INTEGRATION:",
            "  • RESTful APIs for seamless system integration",
            "  • Product catalog management dashboard",
            "  • Real-time order and inventory tracking",
            "  • Automated invoicing and reconciliation",
            "",
            "⏱️ ONBOARDING TIMELINE:",
            "  • Week 1: Partnership agreement and setup",
            "  • Week 2: Product listing and integration",
            "  • Week 3: Staff training and pilot launch",
            "  • Week 4: Full rollout and marketing",
            "",
            "🤝 DEDICATED SUPPORT: Partner success manager assigned to each partner"
        ],
        use_bullets=False
    )

    # Slide 10: Partner Success Stories
    add_content_slide(
        "Partner Success Stories 🌟",
        [
            "🌱 [INPUT SUPPLIER A] - Seeds & Fertilizers:",
            "\"Sales increased 65% in 6 months. Distribution costs down 40%. AgroConnect360 opened up rural markets we couldn't reach before.\"",
            "",
            "🏦 [MICROFINANCE BANK B]:",
            "\"We've disbursed ₦500M in agricultural loans with only 3% default rate. Customer acquisition cost dropped from ₦15,000 to ₦5,000 per farmer.\"",
            "",
            "🏭 [CASSAVA PROCESSOR C]:",
            "\"Forward contracts through AgroConnect360 secured our entire supply chain. Quality improved, costs down 30%, and farmers are happier with fair pricing.\""
        ],
        use_bullets=False
    )

    # Slide 11: Marketing & Co-Branding
    add_two_column_slide(
        "Marketing & Co-Branding Opportunities",
        [
            "📢 JOINT MARKETING:",
            "• Co-branded campaigns",
            "• Partner spotlights in app",
            "• Email and SMS to 350K+ farmers",
            "• Social media promotion (100K+ followers)",
            "",
            "🎓 FARMER EDUCATION:",
            "• Product training workshops",
            "• Demo farms and field days",
            "• Video tutorials in app",
        ],
        [
            "🎁 PROMOTIONAL CAMPAIGNS:",
            "• Seasonal promotions",
            "• Loyalty programs",
            "• Bundled offers",
            "",
            "📊 PERFORMANCE TRACKING:",
            "• Campaign analytics",
            "• Customer insights",
            "• ROI measurement",
            "• A/B testing support"
        ]
    )

    # Slide 12: Technology & Data Benefits
    add_content_slide(
        "Technology & Data Advantages",
        [
            "📊 CUSTOMER INSIGHTS:",
            "  • Farmer demographics, crop preferences, purchasing behavior",
            "  • Geographic distribution and seasonal patterns",
            "  • Product ratings and feedback",
            "",
            "🎯 DEMAND FORECASTING:",
            "  • AI-powered demand predictions",
            "  • Inventory optimization recommendations",
            "  • Market trend analysis",
            "",
            "💳 PAYMENT SECURITY:",
            "  • Escrow system protects all transactions",
            "  • Automated payment reconciliation",
            "  • Fraud detection and prevention",
            "",
            "All data shared in compliance with privacy regulations and partner agreements"
        ],
        use_bullets=False
    )

    # Slide 13: Revenue Potential
    add_content_slide(
        "Revenue Potential for Partners",
        [
            "📈 PROJECTED PARTNER REVENUE (3-Year Horizon):",
            "",
            "YEAR 1:",
            "  • 25,000 active farmers | Partner revenue: ₦500M - ₦1B",
            "",
            "YEAR 2:",
            "  • 100,000 active farmers | Partner revenue: ₦3B - ₦5B",
            "",
            "YEAR 3:",
            "  • 350,000 active farmers | Partner revenue: ₦12B - ₦20B",
            "",
            "💰 AVERAGE REVENUE PER PARTNER:",
            "  • Input suppliers: ₦200M - ₦500M annually",
            "  • Financial institutions: ₦100M - ₦300M annually",
            "  • Offtakers: ₦500M - ₦2B annually"
        ],
        use_bullets=False
    )

    # Slide 14: Partnership Requirements
    add_two_column_slide(
        "Partnership Requirements & Criteria",
        [
            "✅ ELIGIBILITY:",
            "• Registered business entity",
            "• Relevant industry certifications",
            "• Minimum 2 years in operation",
            "• Financial stability",
            "",
            "✅ QUALITY STANDARDS:",
            "• Genuine, quality products",
            "• Fair pricing policies",
            "• Reliable delivery capability",
        ],
        [
            "✅ OPERATIONAL:",
            "• Digital readiness (basic IT infrastructure)",
            "• Customer service capability",
            "• Inventory management systems",
            "",
            "✅ VALUES ALIGNMENT:",
            "• Farmer-centric approach",
            "• Ethical business practices",
            "• Commitment to transparency"
        ]
    )

    # Slide 15: Next Steps
    add_content_slide(
        "Let's Start Our Partnership Journey 🚀",
        [
            "1️⃣ INITIAL DISCUSSION (This Week):",
            "   • Share your partnership interests and goals",
            "   • Understand your product/service offerings",
            "",
            "2️⃣ PARTNERSHIP PROPOSAL (Week 2):",
            "   • Customized partnership model and terms",
            "   • Revenue projections and implementation timeline",
            "",
            "3️⃣ AGREEMENT & SETUP (Week 3-4):",
            "   • Sign partnership agreement",
            "   • Technical integration and onboarding",
            "",
            "4️⃣ LAUNCH & GROW (Month 2+):",
            "   • Pilot launch with select farmers",
            "   • Scale and optimize based on results"
        ],
        use_bullets=False
    )

    # Slide 16: Contact & Closing
    slide = prs.slides.add_slide(prs.slide_layouts[6])
    background = slide.background
    fill = background.fill
    fill.solid()
    fill.fore_color.rgb = PRIMARY_GREEN

    text_box = slide.shapes.add_textbox(Inches(1), Inches(2), Inches(8), Inches(2.5))
    text_frame = text_box.text_frame
    text_frame.text = "Let's Grow Together 🌾\nPartner with AgroConnect360"
    p = text_frame.paragraphs[0]
    p.font.size = Pt(48)
    p.font.bold = True
    p.font.color.rgb = WHITE
    p.alignment = PP_ALIGN.CENTER

    contact_box = slide.shapes.add_textbox(Inches(1), Inches(5), Inches(8), Inches(1.8))
    contact_frame = contact_box.text_frame
    contact_frame.text = "AgroConnect360\n📧 partnerships@agroconnect360.ng | 📱 +234-XXX-XXXX-XXX\n🌐 www.agroconnect360.ng/partners"
    for p in contact_frame.paragraphs:
        p.font.size = Pt(24)
        p.font.color.rgb = WHITE
        p.alignment = PP_ALIGN.CENTER

    # Save presentation
    filename = "presentations/AgroConnect360_Partner_Presentation.pptx"
    prs.save(filename)
    print(f"✅ Partner presentation created: {filename}")
    return filename

if __name__ == "__main__":
    create_partner_presentation()
