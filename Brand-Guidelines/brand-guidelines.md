# Bright Ivy Brand Guidelines

*Last updated: January 2026*
*Source: Extracted from brightivy.com*

---

## Brand Overview

**Brand Name:** Bright Ivy
**Website:** https://www.brightivy.com
**Tagline:** "Crafted to hold the stories that matter"
**Secondary Tagline:** "From moment…to memory."
**Industry:** Premium personalised display cases for keepsakes
**Location:** UK-based (Newmarket, CB8 7SG)
**Company Number:** 14598925

---

## Typography

### Primary Font: Larken

The brand uses **Larken** as its primary typeface throughout the website — a sophisticated serif font that conveys premium quality and timeless elegance.

**Font Stack:**
```css
font-family: Larken, system-ui, -apple-system, "Segoe UI", Roboto, Arial, sans-serif;
```

**Alternative serif stack (some elements):**
```css
font-family: Larken, Georgia, Times, "Times New Roman", serif;
```

### Secondary Font: GT Standard

Used sparingly for specific UI elements:
```css
font-family: GTStandard-M, sans-serif;
```

### Heading Styles

| Element | Font Size | Font Weight | Letter Spacing | Color |
|---------|-----------|-------------|----------------|-------|
| H1 | 48px | 400 (Normal) | 0.72px | #121212 |
| H2 | 28.8px | 400 (Normal) | 0.72px | #121212 |
| H3 | 21.6px | 400 (Normal) | 0.72px | #121212 |
| Body | 16px | 400 (Normal) | Normal | #121212 |

**Note:** Headings use normal weight (400), not bold. The elegance comes from the font itself and generous letter-spacing.

---

## Colour Palette

### Primary Colours

| Colour | Hex | RGB | Usage |
|--------|-----|-----|-------|
| **Near Black** | `#121212` | rgb(18, 18, 18) | Primary text, buttons, headings |
| **Dark Gray** | `#1F1F1F` | rgb(31, 31, 31) | Secondary text |
| **Medium Gray** | `#333333` | rgb(51, 51, 51) | Tertiary text, links |
| **White** | `#FFFFFF` | rgb(255, 255, 255) | Backgrounds, button text |

### Accent Colours

| Colour | Hex | RGB | Usage |
|--------|-----|-----|-------|
| **Gold/Amber** | `#DFBD69` | rgb(223, 189, 105) | Premium accents, highlights, stars |
| **Forest Green** | `#1E352D` | rgb(30, 53, 45) | Footer, dark sections |
| **Light Gray** | `#F7F7F8` | rgb(247, 247, 248) | Section backgrounds |

### CSS Variables (from Shopify theme)

```css
:root {
  --color-button: 18, 18, 18;
  --color-button-text: 255, 255, 255;
}
```

---

## Logos

### Primary Logo (Horizontal - Black)

**For light backgrounds**

```
URL: https://www.brightivy.com/cdn/shop/files/Bright_Ivy_Logo_Horizontal_Black_1227379d-3ee9-4f4f-8c9a-f920494aef18.png
```

**Responsive widths available:**
- `?width=130` - Small (navigation)
- `?width=195` - Medium
- `?width=260` - Large
- `?width=600` - Extra large

### Primary Logo (Horizontal - White)

**For dark backgrounds**

```
URL: https://www.brightivy.com/cdn/shop/files/Bright_Ivy_Logo_Horizontal_White_c166110d-6bd3-4a43-8e90-82e79e622b9f.png
```

**Responsive widths available:**
- `?width=1100` - High resolution

---

## Button Styles

### Primary Button

```css
.button-primary {
  background-color: #121212;
  color: #FFFFFF;
  border-radius: 0px; /* Sharp corners */
  font-family: Larken, system-ui, -apple-system, "Segoe UI", Roboto, Arial, sans-serif;
  padding: 10px 25px;
  border: none;
}
```

### Secondary/Ghost Button

```css
.button-secondary {
  background-color: transparent;
  color: #333333;
  border: 1px solid #333333;
  border-radius: 2px;
  padding: 10px 25px;
}
```

**Design Note:** Bright Ivy uses **sharp corners** (0px border-radius) for primary actions, conveying a clean, modern, premium aesthetic.

---

## Photography Style

### Characteristics

1. **Clean, minimal backgrounds** - Neutral tones, soft gradients
2. **Natural lighting** - Soft, warm, never harsh
3. **Focus on product clarity** - Crystal-clear acrylic visibility
4. **Lifestyle context** - Products shown in elegant home settings
5. **Warm undertones** - Slightly warm colour grading
6. **Professional quality** - High resolution, well-composed

### Photography Naming Convention

Product images use the format: `DSC0XXXX.jpg` or `DSC0XXXX_Text_Overlay.jpg`

---

## Product Images - Baby Memory Case

### Hero/Main Product Image

```
https://www.brightivy.com/cdn/shop/files/DSC06467-2.jpg?v=1768239378&width=1000
```

### Gallery Images (with responsive widths)

All images support these widths: 246, 493, 600, 713, 823, 990, 1100, 1206, 1346, 1426, 1646, 1946

| Image | URL (base) | Description |
|-------|------------|-------------|
| Main product | `DSC06467-2.jpg` | Clean product shot |
| Lifestyle 1 | `DSC00010_Text_Overlay.jpg` | With text overlay |
| Lifestyle 2 | `DSC00013_Text_Overlay.jpg` | With text overlay |
| Lifestyle 3 | `DSC00017_Text_Overlay.jpg` | With text overlay |
| Lifestyle 4 | `DSC00019_Text_Overlay.jpg` | With text overlay |
| Lifestyle 5 | `DSC00023_Text_Overlay.jpg` | With text overlay |
| Lifestyle 6 | `DSC00025_Text_Overlay.jpg` | With text overlay |
| Lifestyle 7 | `DSC00027_Text_Overlay.jpg` | With text overlay |
| Lifestyle 8 | `DSC00033_Text_Overlay.jpg` | With text overlay |
| Lifestyle 9 | `DSC00039_Text_Overlay.jpg` | With text overlay |
| Lifestyle 10 | `DSC00040_Text_Overlay.jpg` | With text overlay |
| Lifestyle 11 | `DSC00043_Text_Overlay.jpg` | With text overlay |
| Lifestyle 12 | `DSC00047_Text_Overlay.jpg` | With text overlay |

**Full URL pattern:**
```
https://www.brightivy.com/cdn/shop/files/[FILENAME]?v=[VERSION]&width=[WIDTH]
```

**Example:**
```
https://www.brightivy.com/cdn/shop/files/DSC00033_Text_Overlay.jpg?v=1769015777&width=1200
```

---

## Other Product Images

### Pet Memory Case
```
https://www.brightivy.com/cdn/shop/files/C3HeritageAHWDogCollarCase_425a0782-4088-4543-b558-92318210bb06.jpg
```

### Coin Display Case
```
https://www.brightivy.com/cdn/shop/files/DSC06501-2_4a710a81-efcd-4b2d-a805-3be9e4c16487.jpg
```

### Fossil Display Case
```
https://www.brightivy.com/cdn/shop/files/DSC06420_c901aef5-c458-4491-804a-56ce2c2f40d6.jpg
```

### Rings Display Case
```
https://www.brightivy.com/cdn/shop/files/DSC06492-2_9a861a85-c9f6-4de0-b489-e7eccd3a3574.jpg
```

### Heirlooms Display Case
```
https://www.brightivy.com/cdn/shop/files/DSC06449-2.jpg
```

### Travel Souvenirs Display Case
```
https://www.brightivy.com/cdn/shop/files/DSC06460-2.jpg
```

### Custom Display Case
```
https://www.brightivy.com/cdn/shop/files/DSC06511-2.jpg
```

### Mementos Display Case
```
https://www.brightivy.com/cdn/shop/files/DSC06444-2.jpg
```

### Hero/Homepage Image
```
https://www.brightivy.com/cdn/shop/files/DSC06553.jpg?v=1766502738&width=3840
```

### Lifestyle Collection Shot
```
https://www.brightivy.com/cdn/shop/files/DSC06538-2_36aa84f6-04e6-464f-87b0-1fb4aa4f3df9.jpg
```

---

## Brand Voice & Messaging

### Tone Characteristics

- **Warm & emotional** — Not cold or corporate
- **Premium & refined** — Quality-focused, never cheap
- **Personal & meaningful** — About memories, not just products
- **Understated elegance** — Confident but not boastful
- **UK English** — British spelling (colour, favourite, mum)

### Key Messages

1. **Display, not storage** — "Memories deserve to be seen, not stored"
2. **Heirloom quality** — "Built to last generations"
3. **Handmade craftsmanship** — "Handmade and shipped in 2 working days"
4. **Premium materials** — "Crystal-clear acrylic" / "Solid oak" / "Sapele Mahogany"
5. **Personalisation** — "Custom laser engraving" / "HD UV-printed backgrounds"

### Section Headlines (from website)

These demonstrate the brand's copywriting style:

- "Preserving the Magic of Their Very First Chapter"
- "The Moment Behind the Memory"
- "Written Just for Them"
- "Safe, Clear, Made to Be Seen"
- "Capture the Milestones"
- "Personalized for a Lifetime"
- "The Perfect Gift for New Arrivals"

### Product Copy Style

```
"They say the days are long, but the years are short—especially that first precious year.
The Bright Ivy Baby Memory Case is designed to hold the tiny treasures that represent
the start of a beautiful life."
```

**Characteristics:**
- Opens with relatable insight
- Connects product to emotional meaning
- Uses em-dashes for sophisticated punctuation
- Focused on the customer's experience, not features

---

## Website Elements

### Navigation Items

- Best Sellers → `/collections/trending-display-cases`
- Create Your Own Case → `/products/custom-display-case`
- Baby Memory Case → `/products/baby-memory-case`
- Pet Memory Case → `/products/pet-memory-case`
- Coin Case → `/products/display-case-for-coins`
- Fossil Case → `/products/display-case-for-fossils`
- Request a Case → `/pages/contact`

### Announcement Bar Messages

1. "Proud to be rated Excellent on TrustPilot ★★★★★"
2. "Handmade and Shipped in just 2 working days"
3. "FREE UK Delivery On Orders Over £50"

### Footer Links

**Explore:**
- Shop → `/collections/all`
- Partners → `/pages/partnership-registration`
- About Us → `/pages/about-us`
- FAQs → `/pages/faqs`
- Contact → `/pages/contact`
- Delivery → `/pages/delivery`

**Legal:**
- Privacy Policy → `/policies/privacy-policy`
- Returns Policy → `/policies/refund-policy`
- Terms of Service → `/policies/terms-of-service`

### Social Links

- Facebook: https://www.facebook.com/brightivyofficial
- Instagram: https://www.instagram.com/brightivyofficial

---

## Product Specifications (Baby Memory Case)

### Sizes Available

| Size | Internal Dimensions |
|------|---------------------|
| C1 | W: 83mm × D: 58mm × H: 82mm |
| C2 | W: 114mm × D: 58mm × H: 112mm |
| C3 | W: 123mm × D: 89mm × H: 108mm |

### Base Options

1. **Black Acrylic** — Modern, minimalist
2. **Solid Oak** — Warm, traditional
3. **Sapele Mahogany** — Rich, premium

### Customisation Options

- **HD Custom Background** — Upload personal photo
- **Laser Engraving** — Name, date, weight, time, custom text

### Pricing

Starting from: **£31.00 GBP** (C1 size, Black Acrylic base)

---

## Trust Signals

### Reviews

- **99 verified reviews**
- **5.0 star average rating**
- Review platform: Okendo

### Payment Methods Accepted

- American Express
- Apple Pay
- Bancontact
- Diners Club
- Discover
- Google Pay
- Klarna
- Maestro
- Mastercard
- Shop Pay
- Union Pay
- Visa

### Shipping

- Free UK delivery on orders over £50
- Handmade and shipped in 2 working days
- Pay in 3 instalments via Shop Pay (orders over £50)

---

## CSS Quick Reference

```css
/* Bright Ivy Brand Styles */

:root {
  /* Colours */
  --bi-black: #121212;
  --bi-dark-gray: #1F1F1F;
  --bi-medium-gray: #333333;
  --bi-white: #FFFFFF;
  --bi-gold: #DFBD69;
  --bi-forest-green: #1E352D;
  --bi-light-gray: #F7F7F8;

  /* Typography */
  --bi-font-primary: Larken, system-ui, -apple-system, "Segoe UI", Roboto, Arial, sans-serif;
  --bi-font-secondary: GTStandard-M, sans-serif;

  /* Spacing */
  --bi-letter-spacing: 0.72px;
}

/* Headings */
h1, h2, h3 {
  font-family: var(--bi-font-primary);
  font-weight: 400;
  letter-spacing: var(--bi-letter-spacing);
  color: var(--bi-black);
}

h1 { font-size: 48px; }
h2 { font-size: 28.8px; }
h3 { font-size: 21.6px; }

/* Buttons */
.bi-button-primary {
  background-color: var(--bi-black);
  color: var(--bi-white);
  font-family: var(--bi-font-primary);
  border-radius: 0;
  padding: 10px 25px;
  border: none;
  cursor: pointer;
}

.bi-button-secondary {
  background-color: transparent;
  color: var(--bi-medium-gray);
  border: 1px solid var(--bi-medium-gray);
  border-radius: 2px;
  padding: 10px 25px;
}
```

---

## Usage Notes

### For Content Creation

1. Always use UK English spelling
2. Refer to "Baby Memory Case" not "Baby Memory Display Case" (product name)
3. Emphasise "display" vs "storage" in marketing copy
4. Use warm, emotional language focused on memories
5. Avoid price-led messaging — focus on meaning and quality

### For Mockups & Designs

1. Use Larken font (or Georgia as fallback)
2. Sharp corners on primary buttons (0px radius)
3. Near-black (#121212) for text, not pure black
4. Gold (#DFBD69) for premium accents sparingly
5. Clean, minimal layouts with generous white space
6. High-quality product photography as hero elements

### Image URL Pattern

To use Bright Ivy images at specific sizes:
```
https://www.brightivy.com/cdn/shop/files/[FILENAME]?width=[WIDTH]
```

Available widths: 246, 493, 600, 713, 823, 990, 1100, 1206, 1346, 1426, 1646, 1946

---

*This document can be referenced in any context window for consistent brand representation.*
