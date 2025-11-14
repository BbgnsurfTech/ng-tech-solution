#!/usr/bin/env python3
"""
AgroConnect360 - Government & Regulatory Stakeholder Presentation
Creates a presentation focused on policy alignment, economic impact, and social benefits
"""

from pptx import Presentation
from pptx.util import Inches, Pt
from pptx.enum.text import PP_ALIGN
from pptx.dml.color import RGBColor

def create_government_presentation():
    """Create a government/regulatory stakeholder presentation"""

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
        "Digitalizing Nigerian Agriculture for National Development"
    )

    # Slide 2: Executive Summary
    add_content_slide(
        "Executive Summary",
        [
            "AgroConnect360 is a comprehensive digital platform transforming Nigeria's agricultural value chain through technology and financial inclusion.",
            "",
            "🎯 MISSION: Empower 40 million Nigerian farmers with digital tools, market access, and financial services",
            "",
            "📊 IMPACT POTENTIAL:",
            "  • 500,000+ jobs created by Year 5",
            "  • ₦50 billion+ in agricultural GDP contribution",
            "  • 30% reduction in post-harvest losses",
            "  • 2 million farmers reached by Year 5",
            "",
            "🤝 ALIGNMENT: Supports Federal Government's agriculture transformation agenda and SDG goals"
        ],
        use_bullets=False
    )

    # Slide 3: National Agricultural Challenges
    add_content_slide(
        "Addressing Critical National Challenges",
        [
            "🌾 LOW PRODUCTIVITY: Nigeria's crop yields 40-60% below global averages",
            "",
            "💸 POST-HARVEST LOSSES: ₦3.5 trillion annual losses (World Bank)",
            "",
            "🏦 FINANCIAL EXCLUSION: 70% of smallholder farmers lack access to formal credit",
            "",
            "🔗 FRAGMENTED VALUE CHAIN: Multiple intermediaries reduce farmer incomes by 40-50%",
            "",
            "📊 DATA GAP: Limited agricultural data for policy and planning",
            "",
            "👥 YOUTH UNEMPLOYMENT: Agriculture employs <5% of youth despite sector potential"
        ],
        use_bullets=False
    )

    # Slide 4: AgroConnect360 Solution
    add_content_slide(
        "How AgroConnect360 Addresses These Challenges",
        [
            "📱 DIGITAL FARM MANAGEMENT: Improve productivity through data-driven farming",
            "",
            "🛒 DIGITAL MARKETPLACE: Eliminate middlemen, increase farmer income by 30-40%",
            "",
            "💳 EMBEDDED FINANCE: Provide loans, savings, insurance to underserved farmers",
            "",
            "🌤️ SMART ADVISORIES: Weather forecasts and agronomy advice reduce crop losses",
            "",
            "📊 DATA INFRASTRUCTURE: Real-time agricultural data for government planning",
            "",
            "👨‍🌾 YOUTH ENGAGEMENT: Modern, tech-enabled farming attracts young people"
        ],
        use_bullets=False
    )

    # Slide 5: Economic Impact
    add_two_column_slide(
        "Economic Impact & Job Creation",
        [
            "💼 DIRECT EMPLOYMENT:",
            "• 2,000+ tech jobs (developers, data scientists)",
            "• 5,000+ field agents and trainers",
            "• 3,000+ customer support roles",
            "",
            "👥 INDIRECT EMPLOYMENT:",
            "• 100,000+ input dealers",
            "• 50,000+ logistics providers",
            "• 200,000+ service providers",
        ],
        [
            "💰 GDP CONTRIBUTION:",
            "• ₦50B+ by Year 5",
            "• 0.5% increase in agriculture GDP",
            "",
            "📈 TAX REVENUE:",
            "• ₦5B+ annual tax contribution",
            "• VAT, corporate tax, PAYE",
            "",
            "🌾 FARMER INCOME:",
            "• 30-40% increase per farmer",
            "• ₦500B+ additional income"
        ]
    )

    # Slide 6: Food Security Impact
    add_content_slide(
        "Strengthening National Food Security",
        [
            "📊 PRODUCTION INCREASE:",
            "  • 25% yield improvement through precision farming",
            "  • Additional 5 million metric tons of food annually",
            "",
            "🗄️ REDUCE WASTE:",
            "  • 30% reduction in post-harvest losses through better market linkages",
            "  • Save ₦1 trillion worth of crops annually",
            "",
            "📈 SUPPLY CHAIN EFFICIENCY:",
            "  • Real-time market data stabilizes food prices",
            "  • Faster movement of produce from farm to market",
            "",
            "🎯 STRATEGIC CROP FOCUS: Cocoa, cassava, rice, maize, yam - critical staples"
        ],
        use_bullets=False
    )

    # Slide 7: Rural Development
    add_content_slide(
        "Driving Rural Development & Inclusion",
        [
            "🌍 RURAL INFRASTRUCTURE:",
            "  • Digital connectivity driving last-mile internet adoption",
            "  • Logistics networks improving rural access",
            "",
            "💰 FINANCIAL INCLUSION:",
            "  • Banking the unbanked: 2M+ farmers with digital wallets",
            "  • ₦50B+ in agricultural credit disbursed",
            "",
            "📚 KNOWLEDGE TRANSFER:",
            "  • 500,000+ farmers trained in modern techniques",
            "  • Technology democratizing expert knowledge",
            "",
            "⚖️ GENDER EQUITY:",
            "  • 40% of users are women farmers",
            "  • Equal access to credit and market opportunities"
        ],
        use_bullets=False
    )

    # Slide 8: Policy Alignment
    add_content_slide(
        "Alignment with National Development Priorities",
        [
            "🇳🇬 NATIONAL DEVELOPMENT PLAN 2021-2025:",
            "  ✅ Economic diversification beyond oil",
            "  ✅ Digital economy transformation",
            "  ✅ Food security and self-sufficiency",
            "",
            "🌾 AGRICULTURAL TRANSFORMATION AGENDA:",
            "  ✅ Value chain development",
            "  ✅ Youth employment in agriculture",
            "  ✅ Technology adoption and innovation",
            "",
            "💼 EASE OF DOING BUSINESS:",
            "  ✅ Digital platforms reducing bureaucracy",
            "  ✅ Transparent marketplace transactions"
        ],
        use_bullets=False
    )

    # Slide 9: SDG Alignment
    add_content_slide(
        "Contributing to Sustainable Development Goals (SDGs)",
        [
            "🎯 SDG 1 - NO POVERTY: Increase farmer incomes by 30-40%",
            "",
            "🎯 SDG 2 - ZERO HUNGER: Improve food production and reduce waste",
            "",
            "🎯 SDG 5 - GENDER EQUALITY: Equal access for women farmers",
            "",
            "🎯 SDG 8 - DECENT WORK: Create 500,000+ quality jobs",
            "",
            "🎯 SDG 9 - INDUSTRY & INNOVATION: Digital infrastructure and innovation",
            "",
            "🎯 SDG 10 - REDUCED INEQUALITY: Bridge rural-urban digital divide",
            "",
            "🎯 SDG 13 - CLIMATE ACTION: Climate-smart agriculture practices"
        ],
        use_bullets=False
    )

    # Slide 10: Regulatory Compliance
    add_two_column_slide(
        "Regulatory Compliance & Data Governance",
        [
            "✅ DATA PROTECTION:",
            "• NITDA compliance",
            "• Secure farmer data",
            "• Privacy by design",
            "",
            "✅ FINANCIAL REGULATION:",
            "• CBN fintech guidelines",
            "• Know-Your-Customer (KYC)",
            "• Anti-money laundering (AML)",
        ],
        [
            "✅ AGRICULTURAL STANDARDS:",
            "• Quality assurance protocols",
            "• Traceability systems",
            "",
            "✅ TAX COMPLIANCE:",
            "• Full VAT remittance",
            "• Corporate tax filing",
            "• Transparent reporting",
            "",
            "✅ CONSUMER PROTECTION:",
            "• Dispute resolution",
            "• Fair trading practices"
        ]
    )

    # Slide 11: Data Sharing for Policy
    add_content_slide(
        "Agricultural Data Infrastructure for Government",
        [
            "📊 REAL-TIME INSIGHTS:",
            "  • Crop production data by region",
            "  • Market prices and trends",
            "  • Farmer demographics and needs",
            "",
            "🎯 POLICY SUPPORT:",
            "  • Evidence-based agricultural policies",
            "  • Early warning systems for food shortages",
            "  • Subsidy targeting and verification",
            "",
            "📈 PLANNING & FORECASTING:",
            "  • Planting season analytics",
            "  • Harvest predictions",
            "  • Input demand forecasting",
            "",
            "🔒 Data shared in anonymized, aggregated form respecting farmer privacy"
        ],
        use_bullets=False
    )

    # Slide 12: Public-Private Partnership Opportunities
    add_content_slide(
        "Partnership Opportunities with Government",
        [
            "🤝 FARMER REGISTRATION & VERIFICATION:",
            "  • Digital farmer database for government programs",
            "  • Biometric verification and KYC services",
            "",
            "💰 SUBSIDY DISTRIBUTION:",
            "  • Digital distribution of input subsidies",
            "  • Transparent, fraud-resistant system",
            "",
            "📚 EXTENSION SERVICES:",
            "  • Platform for government agricultural extension workers",
            "  • Scale expert advice to millions of farmers",
            "",
            "📊 DATA COLLABORATION:",
            "  • Share agricultural insights with Ministry of Agriculture",
            "  • Support evidence-based policy making"
        ],
        use_bullets=False
    )

    # Slide 13: Implementation Roadmap
    add_content_slide(
        "5-Year Implementation & Impact Roadmap",
        [
            "YEAR 1: Pilot & Foundation (2025)",
            "  • 50,000 farmers | 5,000 jobs | ₦2B GDP impact",
            "",
            "YEAR 2: Regional Expansion (2026)",
            "  • 250,000 farmers | 50,000 jobs | ₦10B GDP impact",
            "",
            "YEAR 3: National Scale (2027)",
            "  • 750,000 farmers | 150,000 jobs | ₦25B GDP impact",
            "",
            "YEAR 4-5: Consolidation & West Africa (2028-2029)",
            "  • 2,000,000 farmers | 500,000 jobs | ₦50B GDP impact",
            "",
            "All milestones tied to measurable economic and social impact KPIs"
        ],
        use_bullets=False
    )

    # Slide 14: Request for Government Support
    add_content_slide(
        "Request for Government Support",
        [
            "🤝 REGULATORY SUPPORT:",
            "  • Fast-track fintech and digital platform licensing",
            "  • Regulatory sandbox for innovation",
            "",
            "💰 FINANCIAL SUPPORT:",
            "  • Access to CBN intervention funds for agricultural lending",
            "  • Tax incentives for agtech startups (Pioneer Status)",
            "",
            "📊 DATA ACCESS:",
            "  • Access to government agricultural datasets",
            "  • Collaboration with research institutions",
            "",
            "📢 AWARENESS & ADOPTION:",
            "  • Government endorsement and farmer education campaigns",
            "  • Integration with extension services"
        ],
        use_bullets=False
    )

    # Slide 15: Monitoring & Evaluation
    add_content_slide(
        "Impact Measurement & Reporting Framework",
        [
            "📊 QUARTERLY REPORTING TO GOVERNMENT:",
            "  • Number of farmers reached and active users",
            "  • Job creation (direct and indirect)",
            "  • Agricultural credit disbursed",
            "  • Farmer income changes",
            "  • Food production increases",
            "",
            "🎯 KEY PERFORMANCE INDICATORS:",
            "  • GDP contribution | Tax revenue | Employment created",
            "  • Farmer income improvement | Post-harvest loss reduction",
            "",
            "🔍 INDEPENDENT EVALUATION:",
            "  • Third-party impact assessments",
            "  • Compliance audits and reporting"
        ],
        use_bullets=False
    )

    # Slide 16: Closing
    slide = prs.slides.add_slide(prs.slide_layouts[6])
    background = slide.background
    fill = background.fill
    fill.solid()
    fill.fore_color.rgb = PRIMARY_GREEN

    text_box = slide.shapes.add_textbox(Inches(1), Inches(2), Inches(8), Inches(2.5))
    text_frame = text_box.text_frame
    text_frame.text = "Partnering for Nigeria's\nAgricultural Transformation"
    p = text_frame.paragraphs[0]
    p.font.size = Pt(48)
    p.font.bold = True
    p.font.color.rgb = WHITE
    p.alignment = PP_ALIGN.CENTER

    contact_box = slide.shapes.add_textbox(Inches(1), Inches(5), Inches(8), Inches(1.8))
    contact_frame = contact_box.text_frame
    contact_frame.text = "AgroConnect360\n📧 government@agroconnect360.ng | 📱 +234-XXX-XXXX-XXX\n🌐 www.agroconnect360.ng"
    for p in contact_frame.paragraphs:
        p.font.size = Pt(24)
        p.font.color.rgb = WHITE
        p.alignment = PP_ALIGN.CENTER

    # Save presentation
    filename = "presentations/AgroConnect360_Government_Presentation.pptx"
    prs.save(filename)
    print(f"✅ Government presentation created: {filename}")
    return filename

if __name__ == "__main__":
    create_government_presentation()
