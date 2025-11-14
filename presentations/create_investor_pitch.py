#!/usr/bin/env python3
"""
AgroConnect360 - Investor Pitch Deck Generator
Creates a comprehensive investor presentation for the AgroConnect360 platform
"""

from pptx import Presentation
from pptx.util import Inches, Pt
from pptx.enum.text import PP_ALIGN
from pptx.dml.color import RGBColor

def create_investor_pitch_deck():
    """Create a comprehensive investor pitch deck for AgroConnect360"""

    prs = Presentation()
    prs.slide_width = Inches(10)
    prs.slide_height = Inches(7.5)

    # Define color scheme (matching AgroConnect360 brand)
    PRIMARY_GREEN = RGBColor(46, 125, 50)    # #2E7D32
    SECONDARY_ORANGE = RGBColor(245, 124, 0)  # #F57C00
    ACCENT_TEAL = RGBColor(0, 137, 123)       # #00897B
    WHITE = RGBColor(255, 255, 255)
    DARK_GRAY = RGBColor(33, 33, 33)
    LIGHT_GRAY = RGBColor(240, 240, 240)

    def add_title_slide(title, subtitle=""):
        """Add a title slide with AgroConnect360 branding"""
        slide = prs.slides.add_slide(prs.slide_layouts[6])  # Blank layout

        # Background
        background = slide.background
        fill = background.fill
        fill.solid()
        fill.fore_color.rgb = PRIMARY_GREEN

        # Title
        title_box = slide.shapes.add_textbox(Inches(0.5), Inches(2.5), Inches(9), Inches(1))
        title_frame = title_box.text_frame
        title_frame.text = title
        title_para = title_frame.paragraphs[0]
        title_para.font.size = Pt(54)
        title_para.font.bold = True
        title_para.font.color.rgb = WHITE
        title_para.alignment = PP_ALIGN.CENTER

        # Subtitle
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
        """Add a content slide with title and bullet points or text"""
        slide = prs.slides.add_slide(prs.slide_layouts[6])  # Blank layout

        # Title bar
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

        # Content
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
        """Add a slide with two columns"""
        slide = prs.slides.add_slide(prs.slide_layouts[6])

        # Title bar
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

        # Left column
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

        # Right column
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

    # Slide 1: Title Slide
    add_title_slide(
        "AgroConnect360",
        "Transforming Nigerian Agriculture Through Technology"
    )

    # Slide 2: The Problem
    add_content_slide(
        "The Problem",
        [
            "🌾 40 million Nigerian farmers struggle with market access and fragmented value chains",
            "💰 Post-harvest losses exceed 30% due to poor storage and market linkages",
            "📱 Limited digital infrastructure connecting farmers to buyers and financial services",
            "💸 70% of smallholder farmers lack access to affordable credit and insurance",
            "📊 Information asymmetry leads to unfair pricing and exploitation of farmers",
            "🚜 Low productivity due to limited access to quality inputs and modern farming techniques"
        ],
        use_bullets=True
    )

    # Slide 3: The Solution
    add_content_slide(
        "The Solution: AgroConnect360",
        [
            "📱 All-in-One Platform: Complete agriculture value chain on mobile",
            "🌾 Farm Management: Digital tools for crop tracking, weather forecasts, and expert advisory",
            "🛒 Marketplace: Direct connection between farmers, buyers, input dealers, and service providers",
            "💳 Financial Services: Embedded fintech with digital wallets, loans, and insurance",
            "📈 Data-Driven Insights: AI-powered recommendations and market intelligence",
            "🤝 Community Network: Connect with peers, share knowledge, and access training"
        ],
        use_bullets=True
    )

    # Slide 4: Market Opportunity
    add_content_slide(
        "Massive Market Opportunity",
        [
            "🇳🇬 Nigeria: Africa's largest economy with 220M+ population",
            "🌾 Agriculture: 21% of GDP, largest employment sector (70% rural employment)",
            "👨‍🌾 Target Market: 40 million farmers + input dealers + buyers",
            "💰 Market Size: $35B agriculture sector, growing at 3.5% annually",
            "📱 Mobile Penetration: 85% smartphone penetration in target demographics",
            "🚀 TAM: $2.5B (agriculture fintech + e-commerce + SaaS)",
            "🎯 SAM: $800M (Nigeria + West Africa expansion)",
            "💎 SOM: $50M achievable in 3 years"
        ],
        use_bullets=True
    )

    # Slide 5: Business Model
    add_two_column_slide(
        "Revenue Streams & Business Model",
        [
            "💵 REVENUE STREAMS:",
            "",
            "• Transaction Fees: 3-5% on marketplace sales",
            "",
            "• Loan Interest: 15% APR on agricultural loans",
            "",
            "• SaaS Subscriptions: Premium features for commercial farmers",
            "",
            "• Data Services: Market intelligence and insights",
        ],
        [
            "📊 FINANCIAL PROJECTIONS:",
            "",
            "Year 1: ₦350M ($450K)",
            "  - 25K active users",
            "  - ₦50M GMV",
            "",
            "Year 2: ₦1.5B ($2M)",
            "  - 100K active users",
            "  - ₦300M GMV",
            "",
            "Year 3: ₦5B ($6M)",
            "  - 350K active users",
            "  - ₦1.5B GMV"
        ]
    )

    # Slide 6: Product Features
    add_content_slide(
        "Product Features",
        [
            "🌾 FARM MANAGEMENT: Crop tracking, lifecycle monitoring, harvest predictions",
            "🛒 MARKETPLACE: Buy/sell produce, inputs, equipment with escrow protection",
            "💰 FINANCE: Digital wallet, instant loans (₦10K-₦5M), micro-insurance",
            "🌤️ WEATHER & ADVISORY: 7-day forecasts, planting calendars, pest alerts",
            "📊 ANALYTICS: Farm performance, revenue tracking, expense management",
            "📚 KNOWLEDGE HUB: Training videos, best practices, expert consultations",
            "🤝 COMMUNITY: Farmer cooperatives, peer-to-peer learning, forums"
        ],
        use_bullets=True
    )

    # Slide 7: Competitive Advantage
    add_content_slide(
        "Competitive Advantage",
        [
            "🎯 End-to-End Platform: Only solution covering entire agriculture value chain",
            "💳 Embedded Fintech: Integrated financial services (not just marketplace)",
            "📱 Mobile-First: Designed for low-bandwidth, offline-capable, vernacular languages",
            "🤖 AI-Powered: Machine learning for crop recommendations and yield predictions",
            "🌍 Local Expertise: Deep understanding of Nigerian agricultural context",
            "🤝 Strategic Partnerships: With input manufacturers, offtakers, and financial institutions",
            "📊 Network Effects: Value increases with each user (farmers, buyers, dealers)"
        ],
        use_bullets=True
    )

    # Slide 8: Go-to-Market Strategy
    add_two_column_slide(
        "Go-to-Market Strategy",
        [
            "🎯 PHASE 1 (Months 1-6):",
            "• Focus on cocoa and cashew farmers in Southwest Nigeria",
            "• Partner with farmer cooperatives",
            "• Pilot with 5,000 farmers",
            "",
            "📈 PHASE 2 (Months 7-18):",
            "• Expand to cassava, yam, rice",
            "• Scale to 100K users",
            "• Add more states (Lagos, Oyo, Ogun, Osun)",
        ],
        [
            "🚀 PHASE 3 (Months 19-36):",
            "• National expansion",
            "• 350K+ active users",
            "• West Africa expansion (Ghana, Côte d'Ivoire)",
            "",
            "🤝 PARTNERSHIPS:",
            "• Input dealers (seeds, fertilizers)",
            "• Offtakers and processors",
            "• Financial institutions",
            "• Government agriculture programs"
        ]
    )

    # Slide 9: Traction & Milestones
    add_content_slide(
        "Current Traction & Milestones",
        [
            "✅ Product Development: MVP completed with core features (Farm, Marketplace, Finance, Advisory)",
            "✅ Market Research: 500+ farmer interviews, validated problem-solution fit",
            "✅ Partnerships: LOIs with 3 major input dealers and 2 offtakers",
            "✅ Regulatory: NITDA compliance underway, CBN fintech licensing in progress",
            "✅ Team: Core team of 8 (2 founders, 6 developers/designers)",
            "🎯 Next 90 Days: Launch pilot with 1,000 farmers in Oyo State",
            "🎯 6 Months: 10,000 active users, ₦50M in GMV"
        ],
        use_bullets=True
    )

    # Slide 10: Financial Projections
    add_content_slide(
        "3-Year Financial Projections",
        [
            "📊 YEAR 1: ₦350M ($450K) Revenue",
            "  • Users: 25,000 | GMV: ₦50M | Operating Margin: -40%",
            "",
            "📊 YEAR 2: ₦1.5B ($2M) Revenue",
            "  • Users: 100,000 | GMV: ₦300M | Operating Margin: -10%",
            "",
            "📊 YEAR 3: ₦5B ($6M) Revenue",
            "  • Users: 350,000 | GMV: ₦1.5B | Operating Margin: 15%",
            "",
            "🎯 Path to Profitability: Break-even at Month 28"
        ],
        use_bullets=False
    )

    # Slide 11: Use of Funds
    add_content_slide(
        "Use of Funds - $15M Series A",
        [
            "💻 Product & Technology (40% - $6M):",
            "  • Engineering team expansion, AI/ML capabilities, platform scaling",
            "",
            "📢 Marketing & User Acquisition (30% - $4.5M):",
            "  • Farmer onboarding, cooperative partnerships, brand building",
            "",
            "👥 Team & Operations (20% - $3M):",
            "  • Key hires (CTO, CFO, sales team), office infrastructure",
            "",
            "💰 Working Capital & Reserves (10% - $1.5M):",
            "  • Loan capital pool, operational buffer, contingency"
        ],
        use_bullets=False
    )

    # Slide 12: Team
    add_content_slide(
        "Team & Advisors",
        [
            "👨‍💼 FOUNDING TEAM:",
            "• CEO: 10+ years in agriculture tech and rural development",
            "• CTO: Former senior engineer at major fintech, Stanford CS",
            "• CPO: Ex-product lead at African e-commerce unicorn",
            "",
            "🎓 ADVISORS:",
            "• Dr. [Name]: Former Minister of Agriculture",
            "• [Name]: Director at leading microfinance bank",
            "• [Name]: Partner at top-tier VC firm (agriculture focus)",
            "",
            "👥 Team of 8 full-time, expanding to 25 in Year 1"
        ],
        use_bullets=False
    )

    # Slide 13: Investment Highlights
    add_content_slide(
        "Why Invest in AgroConnect360?",
        [
            "🌍 Massive Market: $35B agriculture sector, 40M farmers, high growth potential",
            "💰 Proven Business Model: Multiple revenue streams with strong unit economics",
            "🚀 Strong Traction: MVP ready, partnerships secured, pilot launching",
            "🎯 Experienced Team: Domain expertise in agtech, fintech, and product",
            "📈 Scalable Platform: Network effects and low marginal cost of expansion",
            "🌍 Social Impact: Improving livelihoods of millions, food security, SDG alignment",
            "💎 Clear Exit Strategy: Strategic acquisition or IPO in 5-7 years"
        ],
        use_bullets=True
    )

    # Slide 14: The Ask
    add_content_slide(
        "The Ask",
        [
            "💵 RAISING: $15M Series A",
            "",
            "🎯 VALUATION: $50M pre-money",
            "",
            "📊 USE OF FUNDS:",
            "  • Scale to 350K users across Nigeria",
            "  • Achieve ₦5B in annual revenue",
            "  • Expand to 3 additional West African countries",
            "  • Build world-class engineering and operations team",
            "",
            "⏱️ RUNWAY: 24 months to profitability",
            "",
            "🎯 NEXT MILESTONE: Series B at $200M valuation (Year 3)"
        ],
        use_bullets=False
    )

    # Slide 15: Contact & Closing
    slide = prs.slides.add_slide(prs.slide_layouts[6])
    background = slide.background
    fill = background.fill
    fill.solid()
    fill.fore_color.rgb = PRIMARY_GREEN

    # Main text
    text_box = slide.shapes.add_textbox(Inches(1), Inches(2), Inches(8), Inches(3))
    text_frame = text_box.text_frame
    text_frame.text = "Let's Transform Nigerian Agriculture Together"
    p = text_frame.paragraphs[0]
    p.font.size = Pt(48)
    p.font.bold = True
    p.font.color.rgb = WHITE
    p.alignment = PP_ALIGN.CENTER

    # Contact info
    contact_box = slide.shapes.add_textbox(Inches(1), Inches(5), Inches(8), Inches(1.5))
    contact_frame = contact_box.text_frame
    contact_frame.text = "AgroConnect360\n📧 investors@agroconnect360.ng | 📱 +234-XXX-XXXX-XXX\n🌐 www.agroconnect360.ng"
    for p in contact_frame.paragraphs:
        p.font.size = Pt(20)
        p.font.color.rgb = WHITE
        p.alignment = PP_ALIGN.CENTER

    # Save presentation
    filename = "presentations/AgroConnect360_Investor_Pitch_Deck.pptx"
    prs.save(filename)
    print(f"✅ Investor pitch deck created: {filename}")
    return filename

if __name__ == "__main__":
    create_investor_pitch_deck()
