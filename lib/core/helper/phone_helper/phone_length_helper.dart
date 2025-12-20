class PhoneHelper {
  static const Map<String, String> _countryTitlesEn = {
    '1': 'USA/Canada',
    '20': 'Egypt',
    '27': 'South Africa',
    '30': 'Greece',
    '31': 'Netherlands',
    '32': 'Belgium',
    '33': 'France',
    '34': 'Spain',
    '36': 'Hungary',
    '39': 'Italy',
    '40': 'Romania',
    '41': 'Switzerland',
    '43': 'Austria',
    '44': 'UK',
    '45': 'Denmark',
    '46': 'Sweden',
    '47': 'Norway',
    '48': 'Poland',
    '49': 'Germany',
    '51': 'Peru',
    '52': 'Mexico',
    '53': 'Cuba',
    '54': 'Argentina',
    '55': 'Brazil',
    '56': 'Chile',
    '57': 'Colombia',
    '58': 'Venezuela',
    '60': 'Malaysia',
    '61': 'Australia',
    '62': 'Indonesia',
    '63': 'Philippines',
    '64': 'New Zealand',
    '65': 'Singapore',
    '66': 'Thailand',
    '81': 'Japan',
    '82': 'South Korea',
    '84': 'Vietnam',
    '86': 'China',
    '90': 'Turkey',
    '91': 'India',
    '92': 'Pakistan',
    '93': 'Afghanistan',
    '94': 'Sri Lanka',
    '95': 'Myanmar',
    '98': 'Iran',
    '212': 'Morocco',
    '213': 'Algeria',
    '216': 'Tunisia',
    '218': 'Libya',
    '220': 'Gambia',
    '221': 'Senegal',
    '225': 'Ivory Coast',
    '234': 'Nigeria',
    '250': 'Rwanda',
    '251': 'Ethiopia',
    '254': 'Kenya',
    '255': 'Tanzania',
    '256': 'Uganda',
    '260': 'Zambia',
    '263': 'Zimbabwe',
    '351': 'Portugal',
    '352': 'Luxembourg',
    '353': 'Ireland',
    '354': 'Iceland',
    '355': 'Albania',
    '358': 'Finland',
    '359': 'Bulgaria',
    '370': 'Lithuania',
    '371': 'Latvia',
    '372': 'Estonia',
    '380': 'Ukraine',
    '381': 'Serbia',
    '385': 'Croatia',
    '386': 'Slovenia',
    '420': 'Czech Republic',
    '421': 'Slovakia',
    '886': 'Taiwan',
    '961': 'Lebanon',
    '962': 'Jordan',
    '963': 'Syria',
    '964': 'Iraq',
    '965': 'Kuwait',
    '966': 'Saudi Arabia',
    '971': 'UAE',
    '974': 'Qatar',
    '977': 'Nepal',
    '998': 'Uzbekistan',
  };

  static const Map<String, String> _countryTitlesAr = {
    '1': 'الولايات المتحدة/كندا',
    '20': 'مصر',
    '27': 'جنوب أفريقيا',
    '30': 'اليونان',
    '31': 'هولندا',
    '32': 'بلجيكا',
    '33': 'فرنسا',
    '34': 'إسبانيا',
    '36': 'المجر',
    '39': 'إيطاليا',
    '40': 'رومانيا',
    '41': 'سويسرا',
    '43': 'النمسا',
    '44': 'المملكة المتحدة',
    '45': 'الدنمارك',
    '46': 'السويد',
    '47': 'النرويج',
    '48': 'بولندا',
    '49': 'ألمانيا',
    '51': 'بيرو',
    '52': 'المكسيك',
    '53': 'كوبا',
    '54': 'الأرجنتين',
    '55': 'البرازيل',
    '56': 'تشيلي',
    '57': 'كولومبيا',
    '58': 'فنزويلا',
    '60': 'ماليزيا',
    '61': 'أستراليا',
    '62': 'إندونيسيا',
    '63': 'الفلبين',
    '64': 'نيوزيلندا',
    '65': 'سنغافورة',
    '66': 'تايلاند',
    '81': 'اليابان',
    '82': 'كوريا الجنوبية',
    '84': 'فيتنام',
    '86': 'الصين',
    '90': 'تركيا',
    '91': 'الهند',
    '92': 'باكستان',
    '93': 'أفغانستان',
    '94': 'سريلانكا',
    '95': 'ميانمار',
    '98': 'إيران',
    '212': 'المغرب',
    '213': 'الجزائر',
    '216': 'تونس',
    '218': 'ليبيا',
    '220': 'غامبيا',
    '221': 'السنغال',
    '225': 'ساحل العاج',
    '234': 'نيجيريا',
    '250': 'رواندا',
    '251': 'إثيوبيا',
    '254': 'كينيا',
    '255': 'تنزانيا',
    '256': 'أوغندا',
    '260': 'زامبيا',
    '263': 'زيمبابوي',
    '351': 'البرتغال',
    '352': 'لوكسمبورغ',
    '353': 'أيرلندا',
    '354': 'آيسلندا',
    '355': 'ألبانيا',
    '358': 'فنلندا',
    '359': 'بلغاريا',
    '370': 'ليتوانيا',
    '371': 'لاتفيا',
    '372': 'إستونيا',
    '380': 'أوكرانيا',
    '381': 'صربيا',
    '385': 'كرواتيا',
    '386': 'سلوفينيا',
    '420': 'جمهورية التشيك',
    '421': 'سلوفاكيا',
    '886': 'تايوان',
    '961': 'لبنان',
    '962': 'الأردن',
    '963': 'سوريا',
    '964': 'العراق',
    '965': 'الكويت',
    '966': 'السعودية',
    '971': 'الإمارات',
    '974': 'قطر',
    '977': 'نيبال',
    '998': 'أوزبكستان',
  };

  static String getCountryTitle(String code, String locale) {
    String title;
    if (locale.startsWith('ar')) {
      title = _countryTitlesAr[code] ?? code;
    } else {
      title = _countryTitlesEn[code] ?? code;
    }

    // More aggressive cleaning
    return title.trim().replaceAll(RegExp(r'\s+'), ' ');
  }

  static const Map<String, int> _countryPhoneLengths = {
    '1': 10, // USA/Canada
    '20': 10, // Egypt
    '27': 9, // South Africa
    '30': 10, // Greece
    '31': 9, // Netherlands
    '32': 9, // Belgium
    '33': 9, // France
    '34': 9, // Spain
    '36': 9, // Hungary
    '39': 10, // Italy
    '40': 9, // Romania
    '41': 9, // Switzerland
    '43': 11, // Austria
    '44': 10, // UK
    '45': 8, // Denmark
    '46': 9, // Sweden
    '47': 8, // Norway
    '48': 9, // Poland
    '49': 11, // Germany
    '51': 9, // Peru
    '52': 10, // Mexico
    '53': 8, // Cuba
    '54': 10, // Argentina
    '55': 11, // Brazil
    '56': 9, // Chile
    '57': 10, // Colombia
    '58': 10, // Venezuela
    '60': 9, // Malaysia
    '61': 9, // Australia
    '62': 10, // Indonesia
    '63': 10, // Philippines
    '64': 9, // New Zealand
    '65': 8, // Singapore
    '66': 9, // Thailand
    '81': 10, // Japan
    '82': 10, // South Korea
    '84': 9, // Vietnam
    '86': 11, // China
    '90': 10, // Turkey
    '91': 10, // India
    '92': 10, // Pakistan
    '93': 9, // Afghanistan
    '94': 9, // Sri Lanka
    '95': 8, // Myanmar
    '98': 10, // Iran
    '212': 9, // Morocco
    '213': 9, // Algeria
    '216': 8, // Tunisia
    '218': 9, // Libya
    '220': 7, // Gambia
    '221': 9, // Senegal
    '225': 8, // Ivory Coast
    '234': 10, // Nigeria
    '250': 9, // Rwanda
    '251': 9, // Ethiopia
    '254': 9, // Kenya
    '255': 9, // Tanzania
    '256': 9, // Uganda
    '260': 9, // Zambia
    '263': 9, // Zimbabwe
    '351': 9, // Portugal
    '352': 9, // Luxembourg
    '353': 9, // Ireland
    '354': 7, // Iceland
    '355': 9, // Albania
    '358': 9, // Finland
    '359': 9, // Bulgaria
    '370': 8, // Lithuania
    '371': 8, // Latvia
    '372': 8, // Estonia
    '380': 9, // Ukraine
    '381': 9, // Serbia
    '385': 9, // Croatia
    '386': 8, // Slovenia
    '420': 9, // Czech Republic
    '421': 9, // Slovakia
    '886': 9, // Taiwan
    '961': 8, // Lebanon
    '962': 9, // Jordan
    '963': 9, // Syria
    '964': 10, // Iraq
    '965': 8, // Kuwait
    '966': 9, // Saudi Arabia
    '971': 9, // UAE
    '974': 8, // Qatar
    '977': 10, // Nepal
    '998': 9, // Uzbekistan
  };
  static Map<String, int> get countryPhoneLengths => _countryPhoneLengths;

  static String? getCountryCode(String phoneNumber) {
    // Remove any '+' symbol if present
    String cleanNumber = phoneNumber.startsWith('+')
        ? phoneNumber.substring(1)
        : phoneNumber;

    String? matchedCode;
    for (String code in _countryPhoneLengths.keys) {
      if (cleanNumber.startsWith(code)) {
        // Check if the remaining digits match the expected length
        String remainingDigits = cleanNumber.substring(code.length);
        int expectedLength = _countryPhoneLengths[code]!;

        if (remainingDigits.length == expectedLength) {
          // If we find a perfect match, return it immediately
          if (matchedCode == null || code.length > matchedCode.length) {
            matchedCode = code;
          }
        }
      }
    }

    return matchedCode != null ? '+$matchedCode' : null;
  }

  static int? getValidLength(String phoneNumber) {
    // Remove any '+' symbol if present
    String cleanNumber = phoneNumber.startsWith('+')
        ? phoneNumber.substring(1)
        : phoneNumber;

    String? matchedCode;
    for (String code in _countryPhoneLengths.keys) {
      if (cleanNumber.startsWith(code)) {
        if (matchedCode == null || code.length > matchedCode.length) {
          matchedCode = code;
        }
      }
    }

    if (matchedCode != null) {
      return matchedCode.length + _countryPhoneLengths[matchedCode]!;
    }

    return null;
  }

  static const countriesRequireLeadingZero = {
    '20', // Egypt
    '962', // Jordan
    '964', // Iraq
    '44', // UK
    '49', // Germany
    '33', // France
    '91', // India
    '81', // Japan
    '82', // South Korea
    '61', // Australia
    '64', // New Zealand
    '92', // Pakistan
    '62', // Indonesia
    '27', // South Africa
    '39', // Italy — special case, keep leading 0 even in international
  };

  static bool isValidPhoneForCountry(String phone, String countryCode) {
    if (phone.isEmpty) return false;
    if (countriesRequireLeadingZero.contains(countryCode) &&
        phone.startsWith('0')) {
      // For these countries, allow leading zero
      return true;
    }
    // For all others, phone should NOT start with 0
    return false;
  }
}
