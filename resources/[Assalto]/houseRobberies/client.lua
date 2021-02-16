local isLockpicking = false
local safe = 0
local safepos = {}
local isRobbing = false
local curHouseCoords = {x = 0, y = 0, z = 0}
local disturbance = 0
local isAgro = false
local myRobbableItems = {}
local robberyped = nil
local robbableHouses = {
 
  [1] = {x = 1437.15, y = -1492.97, z = 63.44, info = 'Fudge Lane 1'},
  [2] = {x = 1379.49, y = -1515.41, z = 58.04, info = 'Fudge Lane 2'},
  [3] = {x = 1338.24, y = -1524.22, z = 54.59, info = 'Fudge Lane 3'},
  [4] = {x = 1316.2, y = -1528.01, z = 51.42, info = 'Fudge Lane 4'},
  [5] = {x = 1231.17, y = -1591.76, z = 53.56, info = 'Fudge Lane 5'},
  [6] = {x = 1205.91, y = -1607.85, z = 50.54, info = 'Fudge Lane 6'},
  [7] = {x = 1192.94, y = -1622.69, z = 45.23, info = 'Fudge Lane 7'},
  [8] = {x = 1192.82, y = -1655.06, z = 43.03, info = 'Fudge Lane 8'},
  [9] = {x = 1214.11, y = -1643.33, z = 48.65, info = 'Fudge Lane 9'},
  [10] = {x = 1244.78, y = -1625.69, z = 53.29, info = 'Fudge Lane 10'},
  [11] = {x = 1261.31, y = -1616.26, z = 54.75, info = 'Fudge Lane 11'},
  [12] = {x = 1286.4, y = -1603.31, z = 54.83, info = 'Fudge Lane 12'},
  [13] = {x = 1327.22, y = -1552.61, z = 54.06, info = 'Fudge Lane 13'},
  [14] = {x = 1360.39, y = -1554.92, z = 55.95, info = 'Fudge Lane 14'},
  [15] = {x = 1382.68, y = -1544.46, z = 57.11, info = 'Fudge Lane 15'},
  [16] = {x = 1365.25, y = -1720.38, z = 65.64, info = 'Amarillo Vista 1'},
  [17] = {x = 1315.17, y = -1732.63, z = 54.71, info = 'Amarillo Vista 2'},
  [18] = {x = 1295.86, y = -1739.44, z = 54.28, info = 'Amarillo Vista 3'},
  [19] = {x = 1258.81, y = -1761.27, z = 49.67, info = 'Amarillo Vista 4'},
  [20] = {x = 1251.01, y = -1735.07, z = 52.03, info = 'Amarillo Vista 5'},
  [21] = {x = 1289.66, y = -1711.45, z = 55.28, info = 'Amarillo Vista 7'},
  [22] = {x = 1316.97, y = -1699.67, z = 57.84, info = 'Amarillo Vista 8'},
  [23] = {x = 1355.45, y = -1690.85, z = 60.5, info = 'Amarillo Vista 9'},
  [24] = {x = -51.01, y = -1783.87, z = 28.31, info = 'Grove Street 1'},
  [25] = {x = -42.56, y = -1792.78, z = 27.83, info = 'Grove Street 2'},
  [26] = {x = 20.57, y = -1844.12, z = 24.61, info = 'Grove Street 3'},
  [27] = {x = 29.32, y = -1853.94, z = 24.07, info = 'Grove Street 4'},
  [28] = {x = 45.32, y = -1864.99, z = 23.28, info = 'Grove Street 5'},
  [29] = {x = 54.44, y = -1873.17, z = 22.81, info = 'Grove Street 6'},
  [30] = {x = 100.48, y = -1913.0, z = 21.21, info = 'Grove Street 7'},
  [31] = {x = 117.81, y = -1920.55, z = 21.33, info = 'Grove Street 8'},
  [32] = {x = 126.4, y = -1929.47, z = 21.39, info = 'Grove Street 9'},
  [33] = {x = 114.05, y = -1960.69, z = 21.34, info = 'Grove Street 10'},
  [34] = {x = 85.31, y = -1959.0, z = 21.13, info = 'Grove Street 11'},
  [35] = {x = 76.92, y = -1948.61, z = 21.18, info = 'Grove Street 12'},
  [36] = {x = 72.94, y = -1938.5, z = 21.17, info = 'Grove Street 13'},
  [37] = {x = 57.03, y = -1922.37, z = 21.92, info = 'Grove Street 14'},
  [38] = {x = 39.59, y = -1911.99, z = 21.96, info = 'Grove Street 15'},
  [39] = {x = 23.75, y = -1895.77, z = 22.78, info = 'Grove Street 16'},
  [40] = {x = 4.58, y = -1883.77, z = 23.7, info = 'Grove Street 17'},
  [41] = {x = -5.8, y = -1871.52, z = 24.16, info = 'Grove Street 18'},
  [42] = {x = -21.18, y = -1858.15, z = 25.4, info = 'Grove Street 19'},
  [43] = {x = -33.71, y = -1847.46, z = 26.2, info = 'Grove Street 20'},
  [44] = {x = -157.6, y = -1680.11, z = 33.44, info = 'Forum Drive 1/Apt1'},
  [45] = {x = -148.39, y = -1688.04, z = 32.88, info = 'Forum Drive 1/Apt2'},
  [46] = {x = -147.3, y = -1688.99, z = 32.88, info = 'Forum Drive 1/Apt3'},
  [47] = {x = -143.08, y = -1692.38, z = 32.88, info = 'Forum Drive 1/Apt4'},
  [48] = {x = -141.89, y = -1693.43, z = 32.88, info = 'Forum Drive 1/Apt5'},
  [49] = {x = -141.79, y = -1693.55, z = 36.17, info = 'Forum Drive 1/Apt6'},
  [50] = {x = -142.19, y = -1692.69, z = 36.17, info = 'Forum Drive 1/Apt7'},
  [51] = {x = -147.39, y = -1688.39, z = 36.17, info = 'Forum Drive 1/Apt8'},
  [52] = {x = -148.69, y = -1687.35, z = 36.17, info = 'Forum Drive 1/Apt9'},
  [53] = {x = -157.54, y = -1679.61, z = 36.97, info = 'Forum Drive 1/Apt10'},
  [54] = {x = -158.86, y = -1680.02, z = 36.97, info = 'Forum Drive 1/Apt11'},
  [55] = {x = -160.83, y = -1637.93, z = 34.03, info = 'Forum Drive 2/Apt1'},
  [56] = {x = -160.0, y = -1636.41, z = 34.03, info = 'Forum Drive 2/Apt2'},
  [57] = {x = -153.87, y = -1641.77, z = 36.86, info = 'Forum Drive 2/Apt3'},
  [58] = {x = -159.85, y = -1636.42, z = 37.25, info = 'Forum Drive 2/Apt4'},
  [59] = {x = -161.31, y = -1638.13, z = 37.25, info = 'Forum Drive 2/Apt5'},
  [60] = {x = -150.79, y = -1625.26, z = 33.66, info = 'Forum Drive 2/Apt6'},
  [61] = {x = -150.74, y = -1622.68, z = 33.66, info = 'Forum Drive 2/Apt7'},
  [62] = {x = -145.59, y = -1617.88, z = 36.05, info = 'Forum Drive 2/Apt8'},
  [63] = {x = -145.84, y = -1614.71, z = 36.05, info = 'Forum Drive 2/Apt9'},
  [64] = {x = -152.23, y = -1624.37, z = 36.85, info = 'Forum Drive 2/Apt10'},
  [65] = {x = -150.38, y = -1625.5, z = 36.85, info = 'Forum Drive 2/Apt11'},
  [66] = {x = -120.58, y = -1575.04, z = 34.18, info = 'Forum Drive 3/Apt1'},
  [67] = {x = -114.73, y = -1579.95, z = 34.18, info = 'Forum Drive 3/Apt2'},
  [68] = {x = -119.6, y = -1585.41, z = 34.22, info = 'Forum Drive 3/Apt3'},
  [69] = {x = -123.81, y = -1590.67, z = 34.21, info = 'Forum Drive 3/Apt4'},
  [70] = {x = -139.85, y = -1598.7, z = 34.84, info = 'Forum Drive 3/Apt6'},
  [71] = {x = -146.85, y = -1596.64, z = 34.84, info = 'Forum Drive 3/Apt7'},
  [72] = {x = -139.49, y = -1588.39, z = 34.25, info = 'Forum Drive 3/Apt8'},
  [73] = {x = -133.47, y = -1581.2, z = 34.21, info = 'Forum Drive 3/Apt9'},
  [74] = {x = -120.63, y = -1575.05, z = 37.41, info = 'Forum Drive 3/Apt10'},
  [75] = {x = -114.71, y = -1580.4, z = 37.41, info = 'Forum Drive 3/Apt11'},
  [76] = {x = -119.53, y = -1585.26, z = 37.41, info = 'Forum Drive 3/Apt12'},
  [77] = {x = -123.67, y = -1590.39, z = 37.41, info = 'Forum Drive 3/Apt13'},
  [78] = {x = -140.08, y = -1598.75, z = 38.22, info = 'Forum Drive 3/Apt15'},
  [79] = {x = -145.81, y = -1597.55, z = 38.22, info = 'Forum Drive 3/Apt16'},
  [80] = {x = -147.47, y = -1596.26, z = 38.22, info = 'Forum Drive 3/Apt17'},
  [81] = {x = -139.77, y = -1587.8, z = 37.41, info = 'Forum Drive 3/Apt18'},
  [82] = {x = -133.78, y = -1580.56, z = 37.41, info = 'Forum Drive 3/Apt19'},
  [82] = {x = 16.5, y = -1443.77, z = 30.95, info = 'Forum Drive 4'},
  [83] = {x = -1.98, y = -1442.55, z = 30.97, info = 'Forum Drive 5'},
  [84] = {x = -32.87, y = -1446.34, z = 31.9, info = 'Forum Drive 7'},
  [85] = {x = -45.73, y = -1445.58, z = 32.43, info = 'Forum Drive 8'},
  [86] = {x = -64.48, y = -1449.57, z = 32.53, info = 'Forum Drive 9'},
  [87] = {x = -167.71, y = -1534.71, z = 35.1, info = 'Forum Drive 10/Apt1'},
  [88] = {x = -180.71, y = -1553.51, z = 35.13, info = 'Forum Drive 10/Apt2'},
  [89] = {x = -187.47, y = -1562.96, z = 35.76, info = 'Forum Drive 10/Apt3'},
  [90] = {x = -191.86, y = -1559.4, z = 34.96, info = 'Forum Drive 10/Apt4'},
  [91] = {x = -195.55, y = -1556.06, z = 34.96, info = 'Forum Drive 10/Apt5'},
  [92] = {x = -183.81, y = -1540.59, z = 34.36, info = 'Forum Drive 10/Apt6'},
  [93] = {x = -179.69, y = -1534.66, z = 34.36, info = 'Forum Drive 10/Apt7'},
  [94] = {x = -175.06, y = -1529.53, z = 34.36, info = 'Forum Drive 10/Apt8'},
  [95] = {x = -167.62, y = -1534.9, z = 38.33, info = 'Forum Drive 10/Apt10'},
  [96] = {x = -180.19, y = -1553.89, z = 38.34, info = 'Forum Drive 10/Apt11'},
  [97] = {x = -186.63, y = -1562.32, z = 39.14, info = 'Forum Drive 10/Apt12'},
  [98] = {x = -188.32, y = -1562.5, z = 39.14, info = 'Forum Drive 10/Apt13'},
  [99] = {x = -192.14, y = -1559.64, z = 38.34, info = 'Forum Drive 10/Apt14'},
  [100] = {x = -195.77, y = -1555.92, z = 38.34, info = 'Forum Drive 10/Apt15'},
  [101] = {x = -184.06, y = -1539.83, z = 37.54, info = 'Forum Drive 10/Apt16'},
  [102] = {x = -179.58, y = -1534.93, z = 37.54, info = 'Forum Drive 10/Apt17'},
  [103] = {x = -174.87, y = -1529.18, z = 37.54, info = 'Forum Drive 10/Apt18'},
  [104] = {x = -208.75, y = -1600.32, z = 34.87, info = 'Forum Drive 11/Apt1'},
  [105] = {x = -210.05, y = -1607.17, z = 34.87, info = 'Forum Drive 11/Apt2'},
  [106] = {x = -212.05, y = -1616.86, z = 34.87, info = 'Forum Drive 11/Apt3'},
  [107] = {x = -213.8, y = -1618.07, z = 34.87, info = 'Forum Drive 11/Apt4'},
  [108] = {x = -221.82, y = -1617.45, z = 34.87, info = 'Forum Drive 11/Apt5'},
  [109] = {x = -223.06, y = -1601.38, z = 34.89, info = 'Forum Drive 11/Apt6'},
  [110] = {x = -222.52, y = -1585.71, z = 34.87, info = 'Forum Drive 11/Apt7'},
  [111] = {x = -218.91, y = -1580.06, z = 34.87, info = 'Forum Drive 11/Apt8'},
  [112] = {x = -216.48, y = -1577.45, z = 34.87, info = 'Forum Drive 11/Apt9'},
  [113] = {x = -206.23, y = -1585.55, z = 34.87, info = 'Forum Drive 11/Apt10'},
  [114] = {x = -206.63, y = -1585.8, z = 38.06, info = 'Forum Drive 11/Apt12'},
  [115] = {x = -216.05, y = -1576.86, z = 38.06, info = 'Forum Drive 11/Apt13'},
  [116] = {x = -218.37, y = -1579.89, z = 38.06, info = 'Forum Drive 11/Apt14'},
  [117] = {x = -222.25, y = -1585.37, z = 38.06, info = 'Forum Drive 11/Apt15'},
  [118] = {x = -222.26, y = -1600.93, z = 38.06, info = 'Forum Drive 11/Apt16'},
  [119] = {x = -222.21, y = -1617.39, z = 38.06, info = 'Forum Drive 11/Apt17'},
  [120] = {x = -214.12, y = -1617.62, z = 38.06, info = 'Forum Drive 11/Apt18'},
  [121] = {x = -212.29, y = -1617.34, z = 38.06, info = 'Forum Drive 11/Apt19'},
  [122] = {x = -210.46, y = -1607.36, z = 38.05, info = 'Forum Drive 11/Apt20'},
  [123] = {x = -209.45, y = -1600.57, z = 38.05, info = 'Forum Drive 11/Apt21'},
  [124] = {x = -216.64, y = -1673.73, z = 34.47, info = 'Forum Drive 12/Apt1'},
  [125] = {x = -224.15, y = -1673.67, z = 34.47, info = 'Forum Drive 12/Apt2'},
  [126] = {x = -224.17, y = -1666.14, z = 34.47, info = 'Forum Drive 12/Apt3'},
  [127] = {x = -224.32, y = -1649.0, z = 34.86, info = 'Forum Drive 12/Apt4'},
  [128] = {x = -216.34, y = -1648.94, z = 34.47, info = 'Forum Drive 12/Apt5'},
  [129] = {x = -212.92, y = -1660.54, z = 34.47, info = 'Forum Drive 12/Apt6'},
  [130] = {x = -212.95, y = -1667.96, z = 34.47, info = 'Forum Drive 12/Apt7'},
  [131] = {x = -216.55, y = -1673.88, z = 37.64, info = 'Forum Drive 12/Apt8'},
  [132] = {x = -224.34, y = -1673.79, z = 37.64, info = 'Forum Drive 12/Apt9'},
  [133] = {x = -223.99, y = -1666.29, z = 37.64, info = 'Forum Drive 12/Apt10'},
  [134] = {x = -224.44, y = -1653.99, z = 37.64, info = 'Forum Drive 12/Apt11'},
  [135] = {x = -223.96, y = -1649.16, z = 38.45, info = 'Forum Drive 12/Apt12'},
  [136] = {x = -216.44, y = -1649.13, z = 37.64, info = 'Forum Drive 12/Apt13'},
  [137] = {x = -212.85, y = -1660.74, z = 37.64, info = 'Forum Drive 12/Apt14'},
  [138] = {x = -212.72, y = -1668.23, z = 37.64, info = 'Forum Drive 12/Apt15'},
  [139] = {x = 207.81, y = -1894.66, z = 24.82, info = 'Covenant Avenue 1'},
  [140] = {x = 192.27, y = -1884.01, z = 24.86, info = 'Covenant Avenue 2'},
  [141] = {x = 170.9, y = -1871.29, z = 24.41, info = 'Covenant Avenue 3'},
  [142] = {x = 149.69, y = -1865.39, z = 24.6, info = 'Covenant Avenue 4'},
  [143] = {x = 130.2, y = -1854.03, z = 25.06, info = 'Covenant Avenue 5'},
  [144] = {x = 104.32, y = -1884.78, z = 24.32, info = 'Covenant Avenue 6'},
  [145] = {x = 114.95, y = -1887.7, z = 23.93, info = 'Covenant Avenue 7'},
  [146] = {x = 127.69, y = -1896.79, z = 23.68, info = 'Covenant Avenue 8'},
  [147] = {x = 148.81, y = -1904.41, z = 23.54, info = 'Covenant Avenue 9'},
  [148] = {x = -1071.77, y = -1566.08, z = 4.39, info = 'Beachside Court 13'},
  [149] = {x = -1073.94, y = -1562.36, z = 4.46, info = 'Beachside Court 14'},
  [150] = {x = -1066.23, y = -1545.34, z = 4.91, info = 'Beachside Court 15'},
  [151] = {x = -113.52, y = -1478.46, z = 33.83, info = 'Carson Avenue 1/Apt1'},
  [152] = {x = -108.04, y = -1473.11, z = 33.83, info = 'Carson Avenue 1/Apt2'},
  [153] = {x = -113.89, y = -1468.64, z = 33.83, info = 'Carson Avenue 1/Apt3'},
  [154] = {x = -123.05, y = -1460.05, z = 33.83, info = 'Carson Avenue 1/Apt4'},
  [155] = {x = -126.68, y = -1456.71, z = 34.57, info = 'Carson Avenue 1/Apt5'},
  [156] = {x = -131.8, y = -1463.15, z = 33.83, info = 'Carson Avenue 1/Apt6'},
  [157] = {x = -125.47, y = -1473.1, z = 33.83, info = 'Carson Avenue 1/Apt7'},
  [158] = {x = -119.61, y = -1478.11, z = 33.83, info = 'Carson Avenue 1/Apt8'},
  [159] = {x = -122.98, y = -1460.25, z = 37.0, info = 'Carson Avenue 1/Apt9'},
  [160] = {x = -127.02, y = -1457.18, z = 37.8, info = 'Carson Avenue 1/Apt10'},
  [161] = {x = -131.92, y = -1463.16, z = 37.0, info = 'Carson Avenue 1/Apt11'},
  [162] = {x = -138.15, y = -1470.49, z = 37.0, info = 'Carson Avenue 1/Apt12'},
  [163] = {x = -125.48, y = -1473.39, z = 37.0, info = 'Carson Avenue 1/Apt13'},
  [164] = {x = -119.87, y = -1477.81, z = 37.0, info = 'Carson Avenue 1/Apt14'},
  [165] = {x = -77.1, y = -1515.61, z = 34.25, info = 'Carson Avenue 2/Apt1'},
  [166] = {x = -71.74, y = -1508.33, z = 33.44, info = 'Carson Avenue 2/Apt2'},
  [167] = {x = -65.73, y = -1513.55, z = 33.44, info = 'Carson Avenue 2/Apt3'},
  [168] = {x = -60.39, y = -1517.48, z = 33.44, info = 'Carson Avenue 2/Apt4'},
  [169] = {x = -54.1, y = -1523.19, z = 33.44, info = 'Carson Avenue 2/Apt5'},
  [170] = {x = -59.84, y = -1530.35, z = 34.24, info = 'Carson Avenue 2/Apt6'},
  [171] = {x = -62.18, y = -1532.27, z = 34.24, info = 'Carson Avenue 2/Apt7'},
  [172] = {x = -68.86, y = -1526.34, z = 34.24, info = 'Carson Avenue 2/Apt8'},
  [173] = {x = -77.3, y = -1515.62, z = 37.42, info = 'Carson Avenue 2/Apt9'},
  [174] = {x = -71.37, y = -1508.76, z = 36.63, info = 'Carson Avenue 2/Apt10'},
  [175] = {x = -65.85, y = -1513.39, z = 36.63, info = 'Carson Avenue 2/Apt11'},
  [176] = {x = -61.03, y = -1517.82, z = 36.63, info = 'Carson Avenue 2/Apt12'},
  [177] = {x = -54.23, y = -1523.33, z = 36.63, info = 'Carson Avenue 2/Apt13'},
  [178] = {x = -60.03, y = -1530.35, z = 37.42, info = 'Carson Avenue 2/Apt14'},
  [179] = {x = -61.53, y = -1532.14, z = 37.42, info = 'Carson Avenue 2/Apt15'},
  [180] = {x = -68.59, y = -1526.2, z = 37.42, info = 'Carson Avenue 2/Apt16'},
  [181] = {x = 252.35, y = -1671.55, z = 29.67, info = 'Brouge Avenue 1'},
  [182] = {x = 241.38, y = -1688.28, z = 29.52, info = 'Brouge Avenue 2'},
  [183] = {x = 223.35, y = -1703.33, z = 29.49, info = 'Brouge Avenue 3'},
  [184] = {x = 216.83, y = -1717.15, z = 29.48, info = 'Brouge Avenue 4'},
  [185] = {x = 198.59, y = -1725.5, z = 29.67, info = 'Brouge Avenue 5'},
  [186] = {x = 152.28, y = -1823.45, z = 27.87, info = 'Brouge Avenue 6'},
  [187] = {x = 249.48, y = -1730.38, z = 29.67, info = 'Brouge Avenue 7'},
  [188] = {x = 257.05, y = -1723.09, z = 29.66, info = 'Brouge Avenue 8'},
  [189] = {x = 269.23, y = -1713.34, z = 29.67, info = 'Brouge Avenue 9'},
  [190] = {x = 281.13, y = -1694.16, z = 29.26, info = 'Brouge Avenue 10'},
  [191] = {x = 332.58, y = -1741.63, z = 29.74, info = 'Roy Lowenstein Blvd 1'},
  [192] = {x = 320.66, y = -1759.78, z = 29.64, info = 'Roy Lowenstein Blvd 2'},
  [193] = {x = 305.15, y = -1775.86, z = 29.1, info = 'Roy Lowenstein Blvd 3'},
  [194] = {x = 299.84, y = -1784.04, z = 28.44, info = 'Roy Lowenstein Blvd 4'},
  [195] = {x = 289.25, y = -1791.99, z = 28.09, info = 'Roy Lowenstein Blvd 5'},
  [196] = {x = 179.23, y = -1923.86, z = 21.38, info = 'Roy Lowenstein Blvd 6'},
  [197] = {x = 165.55, y = -1945.18, z = 20.24, info = 'Roy Lowenstein Blvd 7'},
  [198] = {x = 149.99, y = -1961.59, z = 19.08, info = 'Roy Lowenstein Blvd 8'},
  [199] = {x = 144.14, y = -1969.72, z = 18.86, info = 'Roy Lowenstein Blvd 9'},
  [200] = {x = 140.98, y = -1983.14, z = 18.33, info = 'Roy Lowenstein Blvd 10'},
  [201] = {x = 250.07, y = -1934.4, z = 24.51, info = 'Roy Lowenstein Blvd 11'},
  [202] = {x = 257.39, y = -1927.69, z = 25.45, info = 'Roy Lowenstein Blvd 12'},
  [203] = {x = 269.71, y = -1917.57, z = 26.19, info = 'Roy Lowenstein Blvd 13'},
  [204] = {x = 281.88, y = -1898.45, z = 26.88, info = 'Roy Lowenstein Blvd 14'},
  [205] = {x = 319.74, y = -1853.49, z = 27.53, info = 'Roy Lowenstein Blvd 15'},
  [206] = {x = 328.0, y = -1844.52, z = 27.76, info = 'Roy Lowenstein Blvd 16'},
  [207] = {x = 339.22, y = -1829.24, z = 28.34, info = 'Roy Lowenstein Blvd 17'},
  [208] = {x = 348.85, y = -1820.62, z = 28.9, info = 'Roy Lowenstein Blvd 18'},
  [209] = {x = 405.64, y = -1751.29, z = 29.72, info = 'Roy Lowenstein Blvd 19'},
  [210] = {x = 418.53, y = -1735.9, z = 29.61, info = 'Roy Lowenstein Blvd 20'},
  [211] = {x = 430.99, y = -1725.5, z = 29.61, info = 'Roy Lowenstein Blvd 21'},
  [212] = {x = 442.72, y = -1706.93, z = 29.49, info = 'Roy Lowenstein Blvd 22'},
  [213] = {x = 471.16, y = -1561.47, z = 32.8, info = 'Roy Lowenstein Blvd 23/Apt1'},
  [214] = {x = 465.83, y = -1567.54, z = 32.8, info = 'Roy Lowenstein Blvd 23/Apt2'},
  [215] = {x = 461.39, y = -1573.95, z = 32.8, info = 'Roy Lowenstein Blvd 23/Apt3'},
  [216] = {x = 455.53, y = -1579.34, z = 32.8, info = 'Roy Lowenstein Blvd 23/Apt4'},
  [217] = {x = 442.13, y = -1569.43, z = 32.8, info = 'Roy Lowenstein Blvd 23/Apt5'},
  [218] = {x = 436.5, y = -1563.9, z = 32.8, info = 'Roy Lowenstein Blvd 23/Apt6'},
  [219] = {x = 431.15, y = -1558.66, z = 32.8, info = 'Roy Lowenstein Blvd 23/Apt7'},
  [220] = {x = 500.25, y = -1697.49, z = 29.79, info = 'Jamestown Street 1'},
  [221] = {x = 490.6, y = -1714.39, z = 29.5, info = 'Jamestown Street 2'},
  [223] = {x = 479.51, y = -1736.71, z = 29.16, info = 'Jamestown Street 3'},
  [224] = {x = 475.44, y = -1757.74, z = 28.9, info = 'Jamestown Street 4'},
  [225] = {x = 472.88, y = -1775.22, z = 29.07, info = 'Jamestown Street 5'},
  [226] = {x = 440.01, y = -1830.31, z = 28.37, info = 'Jamestown Street 6'},
  [227] = {x = 428.12, y = -1841.33, z = 28.47, info = 'Jamestown Street 7'},
  [228] = {x = 412.58, y = -1856.23, z = 27.33, info = 'Jamestown Street 8'},
  [229] = {x = 399.67, y = -1864.78, z = 26.72, info = 'Jamestown Street 9'},
  [230] = {x = 386.04, y = -1882.27, z = 25.79, info = 'Jamestown Street 10'},
  [231] = {x = 368.05, y = -1896.76, z = 25.18, info = 'Jamestown Street 11'},
  [232] = {x = 324.15, y = -1937.81, z = 25.02, info = 'Jamestown Street 12'},
  [233] = {x = 312.81, y = -1956.66, z = 24.43, info = 'Jamestown Street 13'},
  [234] = {x = 296.54, y = -1972.44, z = 22.7, info = 'Jamestown Street 14'},
  [235] = {x = 291.23, y = -1980.74, z = 21.61, info = 'Jamestown Street 15'},
  [236] = {x = 280.23, y = -1993.25, z = 20.81, info = 'Jamestown Street 16'},
  [237] = {x = 257.12, y = -2023.84, z = 19.27, info = 'Jamestown Street 17'},
  [238] = {x = 251.39, y = -2029.73, z = 18.51, info = 'Jamestown Street 18'},
  [239] = {x = 236.5, y = -2045.73, z = 18.38, info = 'Jamestown Street 19'},
  [240] = {x = 296.87, y = -2097.86, z = 17.67, info = 'Jamestown Street 20/Apt1'},
  [241] = {x = 295.78, y = -2093.31, z = 17.67, info = 'Jamestown Street 20/Apt2'},
  [242] = {x = 293.68, y = -2087.92, z = 17.67, info = 'Jamestown Street 20/Apt3'},
  [243] = {x = 292.59, y = -2086.38, z = 17.67, info = 'Jamestown Street 20/Apt4'},
  [244] = {x = 289.53, y = -2077.1, z = 17.67, info = 'Jamestown Street 20/Apt5'},
  [245] = {x = 288.21, y = -2072.75, z = 17.67, info = 'Jamestown Street 20/Apt6'},
  [246] = {x = 279.29, y = -2043.26, z = 19.77, info = 'Jamestown Street 20/Apt7'},
  [247] = {x = 280.6, y = -2041.64, z = 19.77, info = 'Jamestown Street 20/Apt8'},
  [248] = {x = 286.69, y = -2034.4, z = 19.77, info = 'Jamestown Street 20/Apt9'},
  [249] = {x = 289.76, y = -2030.74, z = 19.77, info = 'Jamestown Street 20/Apt10'},
  [250] = {x = 323.53, y = -1990.66, z = 24.17, info = 'Jamestown Street 20/Apt11'},
  [251] = {x = 324.82, y = -1988.95, z = 24.17, info = 'Jamestown Street 20/Apt12'},
  [252] = {x = 331.63, y = -1982.15, z = 24.17, info = 'Jamestown Street 20/Apt13'},
  [253] = {x = 333.9, y = -1978.33, z = 24.17, info = 'Jamestown Street 20/Apt14'},
  [254] = {x = 362.6, y = -1986.24, z = 24.13, info = 'Jamestown Street 20/Apt15'},
  [255] = {x = 364.17, y = -1986.78, z = 24.14, info = 'Jamestown Street 20/Apt16'},
  [256] = {x = 375.15, y = -1990.66, z = 24.13, info = 'Jamestown Street 20/Apt18'},
  [257] = {x = 384.27, y = -1994.33, z = 24.24, info = 'Jamestown Street 20/Apt19'},
  [258] = {x = 385.74, y = -1995.01, z = 24.24, info = 'Jamestown Street 20/Apt20'},
  [259] = {x = 405.02, y = -2018.35, z = 23.33, info = 'Jamestown Street 20/Apt21'},
  [260] = {x = 402.43, y = -2024.68, z = 23.25, info = 'Jamestown Street 20/Apt22'},
  [261] = {x = 400.7, y = -2028.47, z = 23.25, info = 'Jamestown Street 20/Apt23'},
  [262] = {x = 397.38, y = -2034.67, z = 23.21, info = 'Jamestown Street 20/Apt24'},
  [263] = {x = 396.04, y = -2037.9, z = 23.04, info = 'Jamestown Street 20/Apt25'},
  [264] = {x = 392.7, y = -2044.32, z = 22.93, info = 'Jamestown Street 20/Apt26'},
  [265] = {x = 382.56, y = -2061.38, z = 21.78, info = 'Jamestown Street 20/Apt27'},
  [266] = {x = 378.73, y = -2067.02, z = 21.38, info = 'Jamestown Street 20/Apt28'},
  [267] = {x = 375.83, y = -2069.96, z = 21.55, info = 'Jamestown Street 20/Apt29'},
  [268] = {x = 371.63, y = -2074.86, z = 21.56, info = 'Jamestown Street 20/Apt30'},
  [269] = {x = 368.99, y = -2078.37, z = 21.38, info = 'Jamestown Street 20/Apt31'},
  [270] = {x = 364.48, y = -2083.31, z = 21.57, info = 'Jamestown Street 20/Apt32'},
  [271] = {x = 341.08, y = -2098.49, z = 18.21, info = 'Jamestown Street 20/Apt33'},
  [272] = {x = 333.01, y = -2106.72, z = 18.02, info = 'Jamestown Street 20/Apt34'},
  [273] = {x = 329.57, y = -2108.85, z = 17.91, info = 'Jamestown Street 20/Apt35'},
  [274] = {x = 324.18, y = -2112.44, z = 17.76, info = 'Jamestown Street 20/Apt36'},
  [275] = {x = 306.34, y = -2098.09, z = 17.53, info = 'Jamestown Street 20/Apt37'},
  [276] = {x = 306.07, y = -2086.4, z = 17.61, info = 'Jamestown Street 20/Apt38'},
  [277] = {x = 303.8, y = -2079.71, z = 17.66, info = 'Jamestown Street 20/Apt39'},
  [278] = {x = 302.18, y = -2076.06, z = 17.69, info = 'Jamestown Street 20/Apt40'},
  [279] = {x = 295.03, y = -2067.07, z = 17.66, info = 'Jamestown Street 20/Apt41'},
  [280] = {x = 286.77, y = -2053.13, z = 19.43, info = 'Jamestown Street 20/Apt42'},
  [281] = {x = 291.13, y = -2047.6, z = 19.66, info = 'Jamestown Street 20/Apt43'},
  [282] = {x = 293.65, y = -2044.56, z = 19.64, info = 'Jamestown Street 20/Apt44'},
  [283] = {x = 331.18, y = -2000.79, z = 23.81, info = 'Jamestown Street 20/Apt45'},
  [284] = {x = 335.45, y = -1995.13, z = 24.05, info = 'Jamestown Street 20/Apt46'},
  [285] = {x = 338.11, y = -1992.45, z = 23.61, info = 'Jamestown Street 20/Apt47'},
  [286] = {x = 356.72, y = -1997.29, z = 24.07, info = 'Jamestown Street 20/Apt48'},
  [287] = {x = 363.17, y = -1999.61, z = 24.05, info = 'Jamestown Street 20/Apt49'},
  [288] = {x = 366.89, y = -2000.92, z = 24.24, info = 'Jamestown Street 20/Apt50'},
  [289] = {x = 373.56, y = -2003.08, z = 24.27, info = 'Jamestown Street 20/Apt51'},
  [290] = {x = 376.97, y = -2004.75, z = 24.05, info = 'Jamestown Street 20/Apt52'},
  [291] = {x = 383.31, y = -2007.28, z = 23.88, info = 'Jamestown Street 20/Apt53'},
  [292] = {x = 393.38, y = -2015.4, z = 23.41, info = 'Jamestown Street 20/Apt54'},
  [293] = {x = 391.99, y = -2016.96, z = 23.41, info = 'Jamestown Street 20/Apt55'},
  [294] = {x = 388.18, y = -2025.47, z = 23.41, info = 'Jamestown Street 20/Apt56'},
  [295] = {x = 383.87, y = -2036.12, z = 23.41, info = 'Jamestown Street 20/Apt58'},
  [296] = {x = 382.6, y = -2037.41, z = 23.41, info = 'Jamestown Street 20/Apt59'},
  [297] = {x = 372.04, y = -2055.52, z = 21.75, info = 'Jamestown Street 20/Apt60'},
  [298] = {x = 370.9, y = -2056.9, z = 21.75, info = 'Jamestown Street 20/Apt61'},
  [299] = {x = 364.62, y = -2064.18, z = 21.75, info = 'Jamestown Street 20/Apt62'},
  [300] = {x = 357.72, y = -2073.24, z = 21.75, info = 'Jamestown Street 20/Apt64'},
  [301] = {x = 356.57, y = -2074.62, z = 21.75, info = 'Jamestown Street 20/Apt65'},
  [302] = {x = 334.14, y = -2092.86, z = 18.25, info = 'Jamestown Street 20/Apt66'},
  [302] = {x = 329.88, y = -2094.65, z = 18.25, info = 'Jamestown Street 20/Apt67'},
  [303] = {x = 321.57, y = -2099.85, z = 18.25, info = 'Jamestown Street 20/Apt68'},
  [304] = {x = 319.72, y = -2100.29, z = 18.25, info = 'Jamestown Street 20/Apt69'},
  [305] = {x = 332.15, y = -2070.86, z = 20.95, info = 'Jamestown Street 20/Apt70'},
  [306] = {x = 324.11, y = -2063.77, z = 20.72, info = 'Jamestown Street 20/Apt72'},
  [307] = {x = 321.03, y = -2061.05, z = 20.74, info = 'Jamestown Street 20/Apt73'},
  [308] = {x = 315.26, y = -2056.94, z = 20.72, info = 'Jamestown Street 20/Apt74'},
  [309] = {x = 312.31, y = -2054.58, z = 20.72, info = 'Jamestown Street 20/Apt75'},
  [310] = {x = 305.98, y = -2044.77, z = 20.9, info = 'Jamestown Street 20/Apt76'},
  [311] = {x = 313.74, y = -2040.53, z = 20.94, info = 'Jamestown Street 20/Apt77'},
  [312] = {x = 317.47, y = -2043.3, z = 20.94, info = 'Jamestown Street 20/Apt78'},
  [313] = {x = 324.69, y = -2049.25, z = 20.94, info = 'Jamestown Street 20/Apt79'},
  [314] = {x = 326.2, y = -2050.54, z = 20.94, info = 'Jamestown Street 20/Apt80'},
  [315] = {x = 333.56, y = -2056.94, z = 20.94, info = 'Jamestown Street 20/Apt81'},
  [316] = {x = 334.57, y = -2058.3, z = 20.94, info = 'Jamestown Street 20/Apt82'},
  [317] = {x = 341.86, y = -2064.11, z = 20.95, info = 'Jamestown Street 20/Apt83'},
  [318] = {x = 345.23, y = -2067.37, z = 20.94, info = 'Jamestown Street 20/Apt84'},
  [319] = {x = 363.43, y = -2046.13, z = 22.2, info = 'Jamestown Street 20/Apt85'},
  [320] = {x = 359.88, y = -2043.38, z = 22.2, info = 'Jamestown Street 20/Apt86'},
  [321] = {x = 352.51, y = -2037.24, z = 22.09, info = 'Jamestown Street 20/Apt87'},
  [322] = {x = 352.15, y = -2034.96, z = 22.36, info = 'Jamestown Street 20/Apt88'},
  [323] = {x = 344.83, y = -2028.81, z = 22.36, info = 'Jamestown Street 20/Apt89'},
  [324] = {x = 343.63, y = -2027.94, z = 22.36, info = 'Jamestown Street 20/Apt90'},
  [325] = {x = 336.17, y = -2021.61, z = 22.36, info = 'Jamestown Street 20/Apt91'},
  [326] = {x = 331.93, y = -2019.28, z = 22.35, info = 'Jamestown Street 20/Apt92'},
  [327] = {x = 335.78, y = -2010.93, z = 22.32, info = 'Jamestown Street 20/Apt93'},
  [328] = {x = 345.65, y = -2014.72, z = 22.4, info = 'Jamestown Street 20/Apt94'},
  [329] = {x = 354.15, y = -2021.71, z = 22.31, info = 'Jamestown Street 20/Apt96'},
  [330] = {x = 357.26, y = -2024.55, z = 22.3, info = 'Jamestown Street 20/Apt97'},
  [331] = {x = 362.71, y = -2028.26, z = 22.25, info = 'Jamestown Street 20/Apt98'},
  [332] = {x = 365.22, y = -2031.53, z = 22.4, info = 'Jamestown Street 20/Apt99'},
  [333] = {x = 371.47, y = -2040.7, z = 22.2, info = 'Jamestown Street 20/Apt100'},
 
}

local robbableItems = {
 [1] = {x = 1.90339700, y = -3.80026800, z = 1.29917900, name = "Frigorifico", isSearched = false},
 [2] = {x = -3.50363200, y = -6.55289400, z = 1.30625800, name = "Gavetas", isSearched = false},
 [3] = {x = -3.50712600, y = -4.13621600, z = 1.29625800, name = "Mesa", isSearched = false},
 [4] = {x = 8.47819500, y = -2.50979300, z = 1.19712300, name = "Armário", isSearched = false},
 [5] = {x = 9.75982700, y = -1.35874100, z = 1.29625800, name = "Armário", isSearched = false},
 [6] = {x = 8.46626300, y = 4.53223600, z = 1.19425800, name = "Guarda-Roupa", isSearched = false},
 [7] = {x = 5.84416200, y = 2.57377400, z = 1.22089100, name = "Mesa", isSearched = false},
 [8] = {x = 3.04164100, y = 0.31671810, z = 3.58363900, name = "Joalheira", isSearched = false},
 [9] = {x = 6.86376900, y = 1.20651200, z = 1.36589100, name = "Debaixo da cama", isSearched = false},
 [10] = {x = 2.03442400, y = -5.61585100, z = 3.30395600, name = "Armários", isSearched = false},
 [11] = {x = -5.53120400, y = 0.76299670, z = 1.77236000, name = "Gabinetes", isSearched = false},
 [12] = {x = -1.24716200, y = 1.07820500, z = 1.69089300, name = "Mesa de Cafe", isSearched = false},
 [13] = {x = 2.91325400, y = -4.2783510, z = 1.82746400, name = "Mesa", isSearched = false},
}

local ESX = nil
local PlayerData = {}

Citizen.CreateThread(function ()
  while ESX == nil do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    Citizen.Wait(1)
  end
  PlayerData = ESX.GetPlayerData()

  while PlayerData == nil do
    Citizen.Wait(10)
  end

end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
 PlayerData = xPlayer
end)

RegisterNetEvent('houseRobberies:attempt')
AddEventHandler('houseRobberies:attempt', function(lockpicks)
  -- SAFE

  if isRobbing and DoesEntityExist(safe) then
    local playerCoords = GetEntityCoords(PlayerPedId(), true)
    if GetDistanceBetweenCoords(playerCoords, safepos.x, safepos.y, safepos.z, true) <= 3.0 then
      TriggerEvent("safecracking:loop",5)

      --if math.random(1, 20) >= 1 then
      if math.random(1, 10) <= 3 then
        TriggerServerEvent('houseRobberies:removeLockpick')
      end
    end
  end
  -- HOUSE

  if lockpicks > 0 and not isRobbing then
    local playerCoords = GetEntityCoords(PlayerPedId(), true)
    ESX.TriggerServerCallback('tqrp_base:getJobsOnline', function(ems, police)
      if police >= 3 then
        nearHouse = false
        for id,v in pairs(robbableHouses) do
          if GetDistanceBetweenCoords(playerCoords, v.x, v.y, v.z, true) <= 2.5 then
            nearHouse = true
            TriggerEvent('lockpickAnimation')
            exports['mythic_progbar']:Progress({
              name = "housrob",
              duration = 15000,
              label = "A arrombar porta",
              useWhileDead = false,
              canCancel = true,
              controlDisables = {},
              animation = {},
              prop = {},  
            }, function(status)
              isLockpicking = false
              if not status then
                if isNight() then
                  if math.random(1, 10) <= 2 then
                    policeAlert(playerCoords)
                  end
                else
                  if math.random(1, 10) <= 7 then
                    policeAlert(playerCoords)
                  end
                end

                if math.random(1, 10) <= 3 then
                  TriggerServerEvent('houseRobberies:removeLockpick')
                end
                
                TriggerEvent('houseRobberies:createHouse', id)
              end
            end)
          end
        end
        if not nearHouse then
          exports['mythic_notify']:SendAlert('error', 'Esta porta é reforçada')
        end
      end
    end)
  elseif lockpicks == 0 and not isRobbing then
    exports['mythic_notify']:SendAlert('error', 'Sem Lockpicks')
    --TriggerEvent('notification', 'Sem Lockpicks', 2)
  elseif not isNight() and not isRobbing then
    exports['mythic_notify']:SendAlert('error', 'Está muito claro cá fora, dá muita cana')
    --TriggerEvent('notification', 'Está muito claro cá fora, dá muita cana', 2)
  end
end)

RegisterCommand("arrombar",function()
  if PlayerData.job.name == 'police' then
    TriggerEvent('houseRobberies:policeattempt')
  end
end)

RegisterNetEvent('houseRobberies:policeattempt')
AddEventHandler('houseRobberies:policeattempt', function()
  local playerCoords = GetEntityCoords(PlayerPedId(), true)
  for id,v in pairs(robbableHouses) do
    if GetDistanceBetweenCoords(playerCoords, v.x, v.y, v.z, true) <= 2.5 then
          TriggerEvent('houseRobberies:policeenter', id)
    end
  end
end)

RegisterNetEvent('houseRobberies:policeenter')
AddEventHandler('houseRobberies:policeenter', function(id)
  local house = robbableHouses[id]

  DoScreenFadeOut(100)
  Citizen.Wait(100)
 
  buildBasicHouse({x = house.x, y = house.y, z = house.z-50})
  Citizen.Wait(3000)
 
  DoScreenFadeIn(100)
  Citizen.Wait(100)
 
  isRobbing = true
  
  while isRobbing do
   Citizen.Wait(10)
   local playerCoords = GetEntityCoords(PlayerPedId(), true)
   if GetDistanceBetweenCoords(playerCoords, house.x+3.6, house.y-15, house.z-50, true) < 2.5 then
    showMessage('Pressiona ~g~E~w~ pra sair da casa')
    if IsControlJustPressed(0, 38) then
     TriggerEvent('houseRobberies:deleteHouse', id)
    end
   end
  end
 end)
 
RegisterNetEvent('houseRobberies:createHouse')
AddEventHandler('houseRobberies:createHouse', function(id)
 local house = robbableHouses[id]

 myRobbableItems = robbableItems

 for i=1,#myRobbableItems do
  myRobbableItems[i]['isSearched'] = false
 end

 DoScreenFadeOut(100)
 Citizen.Wait(100)

 buildBasicHouse({x = house.x, y = house.y, z = house.z-50})
 Citizen.Wait(3000)

 randomAI({x = house.x, y = house.y, z = house.z-50})

 curHouseCoords = {x = house.x, y = house.y, z = house.z-50}
 disturbance = 0
 isAgro = false


 if math.random(1, 10) < 2 then
  TriggerEvent('houseRobberies:createDog')
 end


 DoScreenFadeIn(100)
 Citizen.Wait(100)

 isRobbing = true
 robbing()
 while isRobbing do
  Citizen.Wait(10)
  local playerCoords = GetEntityCoords(PlayerPedId(), true)

  if GetDistanceBetweenCoords(playerCoords, house.x+3.6, house.y-15, house.z-50, true) < 2.5 then
   showMessage('Pressiona ~g~E~w~ pra sair da casa')
   if IsControlJustPressed(0, 38) then
    TriggerEvent('houseRobberies:deleteHouse', id)
   end
  end
 end
end)


RegisterNetEvent('houseRobberies:deleteHouse')
AddEventHandler('houseRobberies:deleteHouse', function(id)
 local house = robbableHouses[id]

 myRobbableItems = robbableItems
 DoScreenFadeOut(100)
 Citizen.Wait(100)

 FreezeEntityPosition(PlayerPedId(), true)
 DeleteSpawnedHouse(id)

 Citizen.Wait(1000)

 SetEntityCoords(PlayerPedId(), house.x, house.y, house.z)
 FreezeEntityPosition(PlayerPedId(), false)

 Citizen.Wait(1000)

 DoScreenFadeIn(100)
 Citizen.Wait(100)


 TriggerEvent("robbery:guiclose")
 disturbance = 0
 isRobbing = false
end)

function isNight()
 local hour = GetClockHours()
 if hour > 19 or hour < 6 then
  return true
 end
end

function randomAI(generator)
 local modelhash = GetHashKey("a_m_m_beach_02")
 RequestModel(modelhash)

 while not HasModelLoaded(modelhash) do
  Citizen.Wait(10)
 end

 local airoll = math.random(5)
 if airoll == 1 then
  robberyped = CreatePed(GetPedType(modelhash), modelhash, generator.x+6.86376900,generator.y+1.20651200,generator.z+1.36589100, 15.0, 1, 1)
  SetEntityCoords(robberyped, generator.x+6.86376900, generator.y+1.20651200, generator.z+1.36589100)
  SetEntityHeading(robberyped, 80.0)
  SetEntityAsMissionEntity(robberyped, false, true)
  loadAnimDict("dead")
  TaskPlayAnim(robberyped, "dead", 'dead_a', 100.0, 1.0, -1, 1, 0, 0, 0, 0)
 elseif airoll == 2 then
  robberyped = CreatePed(GetPedType(modelhash), modelhash, generator.x+6.86376900,generator.y+1.20651200,generator.z+1.36589100, 15.0, 1, 1)
  SetEntityCoords(robberyped, generator.x-1.48765600, generator.y+1.68100600, generator.z+1.21640500)
  SetEntityHeading(robberyped, 190.0)
  SetEntityAsMissionEntity(robberyped, false, true)
  loadAnimDict("dead")
  TaskPlayAnim(robberyped, "dead", 'dead_b', 100.0, 1.0, -1, 1, 0, 0, 0, 0)
 end
end

function avoidLimbo(generator)
  Citizen.CreateThread(function()
    while isRobbing do
      Citizen.Wait(500)
      local coords = GetEntityCoords(PlayerPedId())
      if (coords.z) <= (generator.z-3) then
        SetEntityCoords(PlayerPedId(), coords.x, coords.y, generator.z+1.2)
      end
    end
  end)
end

function robbing()
  Citizen.CreateThread(function()
    loaded = false
    while isRobbing do
    Citizen.Wait(7)
    local generator = {x = curHouseCoords["x"], y = curHouseCoords["y"], z = curHouseCoords["z"]}
    if not loaded then
      avoidLimbo(generator)
      loaded = true
    end
    if isRobbing then
     for i=1,#myRobbableItems do
      if (GetDistanceBetweenCoords(generator.x + myRobbableItems[i]["x"], generator.y + myRobbableItems[i]["y"], generator.z + myRobbableItems[i]["z"], GetEntityCoords(PlayerPedId())) < 1.4) and not myRobbableItems[i]['isSearched'] then
       DrawText3Ds(generator.x + myRobbableItems[i]["x"], generator.y + myRobbableItems[i]["y"], generator.z + myRobbableItems[i]["z"], 'Pressiona [~g~H~w~] para procurar ' .. myRobbableItems[i]["name"])
       if IsControlJustReleased(1, 74) then
        myRobbableItems[i]['isSearched'] = true
        local distance, pedcount = closestNPC()
        local distadd = 0.1
        if pedcount > 0 then
         distadd = distadd + (pedcount / 100)
         local distancealter = (8.0 - distance) / 100
         distadd = distadd + distancealter
        end
  
        distadd = distadd * 100
        disturbance = disturbance + (distadd * 2)
        if math.random(100) > 95 then
          disturbance = disturbance + 10
        end
        exports['mythic_progbar']:Progress({
          name = "housrob",
          duration = 20000,
          label = "A procurar " .. myRobbableItems[i]['name'],
          useWhileDead = false,
          canCancel = true,
          controlDisables = {},
          animation = {},
          prop = {},
        }, function(status)
          if not status then
            TriggerServerEvent('houseRobberies:searchItem')
          end
        end)
       end
      end
      end
  
     if IsPedShooting(PlayerPedId()) then
      disturbance = 90
      if not isAgro then
       agroNPC()
      end
     end
  
     TriggerEvent("robbery:guiupdate", math.ceil(disturbance))
  
     if disturbance > 85 then
      if not calledin then
       local num = 150 - disturbance
       num = math.random(math.ceil(num))
       local fuckup = math.ceil(num)
  
       if fuckup == 2 and GetEntitySpeed(PlayerPedId()) > 0.8 then
        calledin = true
        if not isAgro then
         agroNPC()
         policeAlert(GetEntityCoords(PlayerPedId()))
        end
       end
      end
     end
  
     if GetEntitySpeed(PlayerPedId()) > 1.4 then
      local distance, pedcount = closestNPC()
      local alteredsound = 0.1
      if pedcount > 0 then
       alteredsound = alteredsound + (pedcount / 100)
       local distancealter = (8.0 - distance) / 100
       alteredsound = alteredsound + distancealter
      end
  
      disturbance = disturbance + (3 * alteredsound)
      if GetEntitySpeed(PlayerPedId()) > 2.0 then
       disturbance = disturbance + (3 * alteredsound)
      end
  
      if GetEntitySpeed(PlayerPedId()) > 3.0 then
      disturbance = disturbance + (3 * alteredsound)
      end
     else
      disturbance = disturbance - 0.01
      if disturbance < 0 then
       disturbance = 0
      end
     end
    end
   end
  end)
end









































function buildBasicHouse(generator)
 SetEntityCoords(PlayerPedId(), 347.04724121094, -1000.2844848633, -99.194671630859)
 FreezeEntityPosition(PlayerPedId(), true)
 Citizen.Wait(2000)
 local building = CreateObject(GetHashKey("clrp_house_1"), generator.x, generator.y-0.05, generator.z+1.26253700-89.825, false, false, false)
 FreezeEntityPosition(building, true)
 Citizen.Wait(1000)
 SetEntityCoords(PlayerPedId(), generator.x+3.6, generator.y-14.8, generator.z+2.9)
 SetEntityHeading(PlayerPedId(), 358.106)

 local dt = CreateObject(GetHashKey("V_16_DT"), generator.x-1.21854400, generator.y-1.04389600, generator.z+1.39068600, false, false, false)
 local mpmid01 = CreateObject(GetHashKey("V_16_mpmidapart01"), generator.x+0.52447510, generator.y-5.04953700, generator.z+1.32, false, false, false)
 local mpmid09 = CreateObject(GetHashKey("V_16_mpmidapart09"), generator.x+0.82202150, generator.y+2.29612000, generator.z+1.88, false, false, false)
 local mpmid07 = CreateObject(GetHashKey("V_16_mpmidapart07"), generator.x-1.91445900, generator.y-6.61911300, generator.z+1.45, false, false, false)
 local mpmid03 = CreateObject(GetHashKey("V_16_mpmidapart03"), generator.x-4.82565300, generator.y-6.86803900, generator.z+1.14, false, false, false)
 local midData = CreateObject(GetHashKey("V_16_midapartdeta"), generator.x+2.28558400, generator.y-1.94082100, generator.z+1.32, false, false, false)
 local glow = CreateObject(GetHashKey("V_16_treeglow"), generator.x-1.37408500, generator.y-0.95420070, generator.z+1.135, false, false, false)
 local curtins = CreateObject(GetHashKey("V_16_midapt_curts"), generator.x-1.96423300, generator.y-0.95958710, generator.z+1.280, false, false, false)
 local mpmid13 = CreateObject(GetHashKey("V_16_mpmidapart13"), generator.x-4.65580700, generator.y-6.61684000, generator.z+1.259, false, false, false)
 local mpcab = CreateObject(GetHashKey("V_16_midapt_cabinet"), generator.x-1.16177400, generator.y-0.97333810, generator.z+1.27, false, false, false)
 local mpdecal = CreateObject(GetHashKey("V_16_midapt_deca"), generator.x+2.311386000, generator.y-2.05385900, generator.z+1.297, false, false, false)
 local mpdelta = CreateObject(GetHashKey("V_16_mid_hall_mesh_delta"), generator.x+3.69693000, generator.y-5.80020100, generator.z+1.293, false, false, false)
 local beddelta = CreateObject(GetHashKey("V_16_mid_bed_delta"), generator.x+7.95187400, generator.y+1.04246500, generator.z+1.28402300, false, false, false)
 local bed = CreateObject(GetHashKey("V_16_mid_bed_bed"), generator.x+6.86376900, generator.y+1.20651200, generator.z+1.33589100, false, false, false)
 local beddecal = CreateObject(GetHashKey("V_16_MID_bed_over_decal"), generator.x+7.82861300, generator.y+1.04696700, generator.z+1.34753700, false, false, false)
 local bathDelta = CreateObject(GetHashKey("V_16_mid_bath_mesh_delta"), generator.x+4.45460500, generator.y+3.21322800, generator.z+1.21116100, false, false, false)
 local bathmirror = CreateObject(GetHashKey("V_16_mid_bath_mesh_mirror"), generator.x+3.57740800, generator.y+3.25032000, generator.z+1.48871300, false, false, false)

	--props
 local beerbot = CreateObject(GetHashKey("Prop_CS_Beer_Bot_01"), generator.x+1.73134600, generator.y-4.88520200, generator.z+1.91083000, false, false, false)
 local couch = CreateObject(GetHashKey("v_res_mp_sofa"), generator.x-1.48765600, generator.y+1.68100600, generator.z+1.33640500, false, false, false)
 local chair = CreateObject(GetHashKey("v_res_mp_stripchair"), generator.x-4.44770800, generator.y-1.78048800, generator.z+1.21640500, false, false, false)
 local chair2 = CreateObject(GetHashKey("v_res_tre_chair"), generator.x+2.91325400, generator.y-5.27835100, generator.z+1.22746400, false, false, false)
 local plant = CreateObject(GetHashKey("Prop_Plant_Int_04a"), generator.x+2.78941300, generator.y-4.39133900, generator.z+2.12746400, false, false, false)
 local lamp = CreateObject(GetHashKey("v_res_d_lampa"), generator.x-3.61473100, generator.y-6.61465100, generator.z+2.09373700, false, false, false)
 local fridge = CreateObject(GetHashKey("v_res_fridgemodsml"), generator.x+1.90339700, generator.y-3.80026800, generator.z+1.29917900, false, false, false)
 local micro = CreateObject(GetHashKey("prop_micro_01"), generator.x+2.03442400, generator.y-4.64585100, generator.z+2.28995600, false, false, false)
 local sideBoard = CreateObject(GetHashKey("V_Res_Tre_SideBoard"), generator.x+2.84053000, generator.y-4.30947100, generator.z+1.24577300, false, false, false)
 local bedSide = CreateObject(GetHashKey("V_Res_Tre_BedSideTable"), generator.x-3.50363200, generator.y-6.55289400, generator.z+1.30625800, false, false, false)
 local lamp2 = CreateObject(GetHashKey("v_res_d_lampa"), generator.x+2.69674700, generator.y-3.83123500, generator.z+2.09373700, false, false, false)
 local plant2 = CreateObject(GetHashKey("v_res_tre_tree"), generator.x-4.96064800, generator.y-6.09898500, generator.z+1.31631400, false, false, false)
 local table = CreateObject(GetHashKey("V_Res_M_DineTble_replace"), generator.x-3.50712600, generator.y-4.13621600, generator.z+1.29625800, false, false, false)
 local tv = CreateObject(GetHashKey("Prop_TV_Flat_01"), generator.x-5.53120400, generator.y+0.76299670, generator.z+2.17236000, false, false, false)
 local plant3 = CreateObject(GetHashKey("v_res_tre_plant"), generator.x-5.14112800, generator.y-2.78951000, generator.z+1.25950800, false, false, false)
 local chair3 = CreateObject(GetHashKey("v_res_m_dinechair"), generator.x-3.04652400, generator.y-4.95971200, generator.z+1.19625800, false, false, false)
 local lampStand = CreateObject(GetHashKey("v_res_m_lampstand"), generator.x+1.26588400, generator.y+3.68883900, generator.z+1.35556700, false, false, false)
 local stool = CreateObject(GetHashKey("V_Res_M_Stool_REPLACED"), generator.x-3.23216300, generator.y+2.06159000, generator.z+1.20556700, false, false, false)
 local chair4 = CreateObject(GetHashKey("v_res_m_dinechair"), generator.x-2.82237200, generator.y-3.59831300, generator.z+1.25950800, false, false, false)
 local chair5 = CreateObject(GetHashKey("v_res_m_dinechair"), generator.x-4.14955100, generator.y-4.71316600, generator.z+1.19625800, false, false, false)
 local chair6 = CreateObject(GetHashKey("v_res_m_dinechair"), generator.x-3.80622900, generator.y-3.37648300, generator.z+1.19625800, false, false, false)
 local plant4 = CreateObject(GetHashKey("v_res_fa_plant01"), generator.x+2.97859200, generator.y+2.55307400, generator.z+1.85796300, false, false, false)
 local storage = CreateObject(GetHashKey("v_res_tre_storageunit"), generator.x+8.47819500, generator.y-2.50979300, generator.z+1.19712300, false, false, false)
 local storage2 = CreateObject(GetHashKey("v_res_tre_storagebox"), generator.x+9.75982700, generator.y-1.35874100, generator.z+1.29625800, false, false, false)
 local basketmess = CreateObject(GetHashKey("v_res_tre_basketmess"), generator.x+8.70730600, generator.y-2.55503600, generator.z+1.94059590, false, false, false)
 local lampStand2 = CreateObject(GetHashKey("v_res_m_lampstand"), generator.x+9.54306000, generator.y-2.50427700, generator.z+1.30556700, false, false, false)
 local plant4 = CreateObject(GetHashKey("Prop_Plant_Int_03a"), generator.x+9.87521400, generator.y+3.90917400, generator.z+1.20829700, false, false, false)
 local basket = CreateObject(GetHashKey("v_res_tre_washbasket"), generator.x+9.39091500, generator.y+4.49676300, generator.z+1.19625800, false, false, false)
 local wardrobe = CreateObject(GetHashKey("V_Res_Tre_Wardrobe"), generator.x+8.46626300, generator.y+4.53223600, generator.z+1.19425800, false, false, false)
 local basket2 = CreateObject(GetHashKey("v_res_tre_flatbasket"), generator.x+8.51593000, generator.y+4.55647300, generator.z+3.46737300, false, false, false)
 local basket3 = CreateObject(GetHashKey("v_res_tre_basketmess"), generator.x+7.57797200, generator.y+4.55198800, generator.z+3.46737300, false, false, false)
 local basket4 = CreateObject(GetHashKey("v_res_tre_flatbasket"), generator.x+7.12286400, generator.y+4.54689200, generator.z+3.46737300, false, false, false)
 local wardrobe2 = CreateObject(GetHashKey("V_Res_Tre_Wardrobe"), generator.x+7.24382000, generator.y+4.53423500, generator.z+1.19625800, false, false, false)
 local basket5 = CreateObject(GetHashKey("v_res_tre_flatbasket"), generator.x+8.03364600, generator.y+4.54835500, generator.z+3.46737300, false, false, false)
 local switch = CreateObject(GetHashKey("v_serv_switch_2"), generator.x+6.28086900, generator.y-0.68169880, generator.z+2.30326000, false, false, false)
 local table2 = CreateObject(GetHashKey("V_Res_Tre_BedSideTable"), generator.x+5.84416200, generator.y+2.57377400, generator.z+1.22089100, false, false, false)
 local lamp3 = CreateObject(GetHashKey("v_res_d_lampa"), generator.x+5.84912100, generator.y+2.58001100, generator.z+1.95311890, false, false, false)
 --local laundry = CreateObject(GetHashKey("v_res_mlaundry"), generator.x+5.77729800, generator.y+4.60211400, generator.z+1.19674400, false, false, false)
 local ashtray = CreateObject(GetHashKey("Prop_ashtray_01"), generator.x-1.24716200, generator.y+1.07820500, generator.z+1.87089300, false, false, false)
 local candle1 = CreateObject(GetHashKey("v_res_fa_candle03"), generator.x-2.89289900, generator.y-4.35329700, generator.z+2.02881310, false, false, false)
 local candle2 = CreateObject(GetHashKey("v_res_fa_candle02"), generator.x-3.99865700, generator.y-4.06048500, generator.z+2.02530190, false, false, false)
 local candle3 = CreateObject(GetHashKey("v_res_fa_candle01"), generator.x-3.37733400, generator.y-3.66639800, generator.z+2.02526200, false, false, false)
 local woodbowl = CreateObject(GetHashKey("v_res_m_woodbowl"), generator.x-3.50787400, generator.y-4.11983000, generator.z+2.02589900, false, false, false)
 local tablod = CreateObject(GetHashKey("V_Res_TabloidsA"), generator.x-0.80513000, generator.y+0.51389600, generator.z+1.18418800, false, false, false)
 local tapeplayer = CreateObject(GetHashKey("Prop_Tapeplayer_01"), generator.x-1.26010100, generator.y-3.62966400, generator.z+2.37883200, false, false, false)
 local woodbowl2 = CreateObject(GetHashKey("v_res_tre_fruitbowl"), generator.x+2.77764900, generator.y-4.138297000, generator.z+2.10340100, false, false, false)
 local sculpt = CreateObject(GetHashKey("v_res_sculpt_dec"), generator.x+3.03932200, generator.y+1.62726400, generator.z+3.58363900, false, false, false)
 local jewlry = CreateObject(GetHashKey("v_res_jewelbox"), generator.x+3.04164100, generator.y+0.31671810, generator.z+3.58363900, false, false, false)
 local basket6 = CreateObject(GetHashKey("v_res_tre_basketmess"), generator.x-1.64906300, generator.y+1.62675900, generator.z+1.39038500, false, false, false)
 local basket7 = CreateObject(GetHashKey("v_res_tre_flatbasket"), generator.x-1.63938900, generator.y+0.91133310, generator.z+1.39038500, false, false, false)
 local basket8 = CreateObject(GetHashKey("v_res_tre_flatbasket"), generator.x-1.19923400, generator.y+1.69598600, generator.z+1.39038500, false, false, false)
 local basket9 = CreateObject(GetHashKey("v_res_tre_basketmess"), generator.x-1.18293800, generator.y+0.91436380, generator.z+1.39038500, false, false, false)
 local bowl = CreateObject(GetHashKey("v_res_r_sugarbowl"), generator.x-0.26029210, generator.y-6.66716800, generator.z+3.77324900, false, false, false)
 local breadbin = CreateObject(GetHashKey("Prop_Breadbin_01"), generator.x+2.09788500, generator.y-6.57634000, generator.z+2.24041900, false, false, false)
 local knifeblock = CreateObject(GetHashKey("v_res_mknifeblock"), generator.x+1.82084700, generator.y-6.58438500, generator.z+2.27399500, false, false, false)
 local toaster = CreateObject(GetHashKey("prop_toaster_01"), generator.x-1.05790700, generator.y-6.59017400, generator.z+2.26793200, false, false, false)
 local wok = CreateObject(GetHashKey("prop_wok"), generator.x+2.01728800, generator.y-5.57091500, generator.z+2.31793200, false, false, false)
 local plant5 = CreateObject(GetHashKey("Prop_Plant_Int_03a"), generator.x+2.55015600, generator.y+4.60183900, generator.z+1.20829700, false, false, false)
 local tumbler = CreateObject(GetHashKey("p_tumbler_cs2_s"), generator.x-0.90916440, generator.y-4.24099100, generator.z+2.24693200, false, false, false)
 local wisky = CreateObject(GetHashKey("p_whiskey_bottle_s"), generator.x-0.92809300, generator.y-3.99099100, generator.z+2.24693200, false, false, false)
 local tissue = CreateObject(GetHashKey("v_res_tissues"), generator.x+7.95889300, generator.y-2.54847100, generator.z+1.94013400, false, false, false)
 local pants = CreateObject(GetHashKey("V_16_Ap_Mid_Pants4"), generator.x+7.55366500, generator.y-0.25457100, generator.z+1.33009200, false, false, false)
 local pants2 = CreateObject(GetHashKey("V_16_Ap_Mid_Pants5"), generator.x+7.76753200, generator.y+3.00476500, generator.z+1.33052800, false, false, false)
 local hairdryer = CreateObject(GetHashKey("v_club_vuhairdryer"), generator.x+8.12616000, generator.y-2.50562000, generator.z+1.96009390, false, false, false)

 FreezeEntityPosition(dt,true)
 FreezeEntityPosition(mpmid01,true)
 FreezeEntityPosition(mpmid09,true)
 FreezeEntityPosition(mpmid07,true)
 FreezeEntityPosition(mpmid03,true)
 FreezeEntityPosition(midData,true)
 FreezeEntityPosition(glow,true)
 FreezeEntityPosition(curtins,true)
 FreezeEntityPosition(mpmid13,true)
 FreezeEntityPosition(mpcab,true)
 FreezeEntityPosition(mpdecal,true)
 FreezeEntityPosition(mpdelta,true)
 FreezeEntityPosition(couch,true)
 FreezeEntityPosition(chair,true)
 FreezeEntityPosition(chair2,true)
 FreezeEntityPosition(plant,true)
 FreezeEntityPosition(lamp,true)
 FreezeEntityPosition(fridge,true)
 FreezeEntityPosition(micro,true)
 FreezeEntityPosition(sideBoard,true)
 FreezeEntityPosition(bedSide,true)
 FreezeEntityPosition(plant2,true)
 FreezeEntityPosition(table,true)
 FreezeEntityPosition(tv,true)
 FreezeEntityPosition(plant3,true)
 FreezeEntityPosition(chair3,true)
 FreezeEntityPosition(lampStand,true)
 FreezeEntityPosition(chair4,true)
 FreezeEntityPosition(chair5,true)
 FreezeEntityPosition(chair6,true)
 FreezeEntityPosition(plant4,true)
 FreezeEntityPosition(storage2,true)
 FreezeEntityPosition(basket,true)
 FreezeEntityPosition(wardrobe,true)
 FreezeEntityPosition(wardrobe2,true)
 FreezeEntityPosition(table2,true)
 FreezeEntityPosition(lamp3,true)
 -- FreezeEntityPosition(laundry,true)
 FreezeEntityPosition(beddelta,true)
 FreezeEntityPosition(bed,true)
 FreezeEntityPosition(beddecal,true)
 FreezeEntityPosition(tapeplayer,true)
 FreezeEntityPosition(basket7,true)
 FreezeEntityPosition(basket6,true)
 FreezeEntityPosition(basket8,true)
 FreezeEntityPosition(basket9,true)

 if math.random(1, 10) >= 6 then
  CreateSafe(generator.x+6.2,generator.y+4.52972300,generator.z+1.32609800)
 end

 SetEntityHeading(beerbot,GetEntityHeading(beerbot)+90)
 SetEntityHeading(couch,GetEntityHeading(couch)-90)
 SetEntityHeading(chair,GetEntityHeading(chair)+getRotation(0.28045480))
 SetEntityHeading(chair2,GetEntityHeading(chair2)+getRotation(0.3276100))
 SetEntityHeading(fridge,GetEntityHeading(chair2)+160)
 SetEntityHeading(micro,GetEntityHeading(micro)-90)
 SetEntityHeading(sideBoard,GetEntityHeading(sideBoard)+90)
 SetEntityHeading(bedSide,GetEntityHeading(bedSide)+180)
 SetEntityHeading(tv,GetEntityHeading(tv)+90)
 SetEntityHeading(plant3,GetEntityHeading(plant3)+90)
 SetEntityHeading(chair3,GetEntityHeading(chair3)+200)
 SetEntityHeading(chair4,GetEntityHeading(chair3)+100)
 SetEntityHeading(chair5,GetEntityHeading(chair5)+135)
 SetEntityHeading(chair6,GetEntityHeading(chair6)+10)
 SetEntityHeading(storage,GetEntityHeading(storage)+180)
 SetEntityHeading(storage2,GetEntityHeading(storage2)-90)
 SetEntityHeading(table2,GetEntityHeading(table2)+90)
 SetEntityHeading(tapeplayer,GetEntityHeading(tapeplayer)+90)
 SetEntityHeading(knifeblock,GetEntityHeading(knifeblock)+180)
 FreezeEntityPosition(PlayerPedId(),false)
end

function DeleteSpawnedHouse(id)
 local housePosition = robbableHouses[id]
 local handle, ObjectFound = FindFirstObject()
 local success
 repeat
  local pos = GetEntityCoords(ObjectFound)
  local distance = GetDistanceBetweenCoords(housePosition["x"], housePosition["y"], (housePosition["z"] - 24.0), pos, true)
  if distance < 35.0 and ObjectFound ~= PlayerPedId() then
   if IsEntityAPed(ObjectFound) then
    if not IsPedAPlayer(ObjectFound) then
     DeleteObject(ObjectFound)
    end
   else
    DeleteObject(ObjectFound)
   end
  end
  success, ObjectFound = FindNextObject(handle)
 until not success
 EndFindObject(handle)
end


function getRotation(input)
	return 360/(10*input)
end

AddEventHandler('lockpickAnimation', function()
 isLockpicking = true
 loadAnimDict('veh@break_in@0h@p_m_one@')
 while isLockpicking do
  if not IsEntityPlayingAnim(PlayerPedId(), "veh@break_in@0h@p_m_one@", "low_force_entry_ds", 3) then
   TaskPlayAnim(PlayerPedId(), "veh@break_in@0h@p_m_one@", "low_force_entry_ds", 1.0, 1.0, 1.0, 1, 0.0, 0, 0, 0)
   Citizen.Wait(1500)
   ClearPedTasks(PlayerPedId())
  end
  Citizen.Wait(1)
 end
 ClearPedTasks(PlayerPedId())
end)

function loadAnimDict(dict)
 RequestAnimDict(dict)
 while not HasAnimDictLoaded(dict) do
  Citizen.Wait(10)
 end
end


function showMessage(msg)
 BeginTextCommandDisplayHelp("STRING")
 AddTextComponentScaleform(msg)
 EndTextCommandDisplayHelp(0, false, false, -1)
end

function DrawText3Ds(x,y,z, text)
  local onScreen,_x,_y=World3dToScreen2d(x,y,z)
  local px,py,pz=table.unpack(GetGameplayCamCoords())
  SetTextScale(0.35, 0.35)
  SetTextFont(6)
  SetTextProportional(1)
  SetTextColour(255, 255, 255, 215)
  SetTextOutline()
  SetTextEntry("STRING")
  SetTextCentre(1)
  AddTextComponentString(text)
  DrawText(_x,_y)
  local factor = (string.len(text)) / 370
  DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
end

function closestNPC()
 local playerCoords = GetEntityCoords(PlayerPedId())
 local handle, ped = FindFirstPed()
 local success
 local rped = nil
 local distanceFrom = 999.0
 local pedcount = 0
 repeat
  local pos = GetEntityCoords(ped)
  local distance = GetDistanceBetweenCoords(playerCoords, pos, true)
  if distance < 25.0 and ped ~= PlayerPedId() and not IsPedAPlayer(ped) then
   pedcount = pedcount + 1
   if (distance < distanceFrom) then
    distanceFrom = distance
    rped = ped
   end
  end
 success, ped = FindNextPed(handle)
 until not success
  EndFindPed(handle)
 return distanceFrom, pedcount
end



local attackDog = nil


function agroNPC()
 local playerCoords = GetEntityCoords(PlayerPedId())
 local handle, ped = FindFirstPed()
 local success
 local rped = nil
 local distanceFrom = 999.0
 local pedcount = 0
 repeat
  local pos = GetEntityCoords(ped)
  local distance = GetDistanceBetweenCoords(playerCoords, pos, true)
  if distance < 35.0 and ped ~= PlayerPedId() and not IsPedAPlayer(ped) then
   ClearPedTasksImmediately(ped)
   SetPedDropsWeaponsWhenDead(ped,false)
   GiveWeaponToPed(ped, GetHashKey('WEAPON_BAT'), 150, 0, 1)
   TaskCombatPed(ped, PlayerPedId(), 0, 16)
   SetPedKeepTask(ped, true)
   isAgro = true
  end
  success, ped = FindNextPed(handle)
 until not success
 EndFindPed(handle)
end



AddEventHandler('houseRobberies:createDog', function()
 if not DoesEntityExist(attackDog) then
  local model = GetHashKey("A_C_Rottweiler")

  RequestModel(model)
  while not HasModelLoaded(model) do
   RequestModel(model)
   Citizen.Wait(100)
  end

  attackDog = CreatePed(GetPedType(model), model, curHouseCoords.x+3.70339700, curHouseCoords.y+-3.80026800, curHouseCoords.z+2.29917900, 90, 1, 0)
  Citizen.Wait(1500)
  TaskCombatPed(attackDog, PlayerPedId(), 0, 16)
  SetPedKeepTask(attackDog, true)
  Citizen.Wait(45000)
  SetEntityAsNoLongerNeeded(attackDog)
  attackDog = 0
 end
end)

function policeAlert(playerCoords)
  TriggerServerEvent("tqrp_outlawalert:server:NewAlert", 
    'police', "Assalto a habitação", "Desconhecido", "person", "gps_fixed", 1, 
    playerCoords.x, playerCoords.y, playerCoords.z, 313, 75, "10-90"
  )

  Citizen.Wait(10000)

  TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 20.0, 'alarm', 0.2)
end





























function CreateSafe(x,y,z)
	safespawned = true
	safepos = {["x"] = x, ["y"] = y, ["z"] = z}

	RequestModel(GetHashKey("prop_ld_int_safe_01"))
	while not HasModelLoaded(GetHashKey("prop_ld_int_safe_01")) do
   Citizen.Wait(100)
	end

	safe = CreateObject(GetHashKey("prop_ld_int_safe_01"), x, y, z,true, false, false)
	FreezeEntityPosition(safe,true)
end

RegisterNetEvent('safe:success')
AddEventHandler('safe:success', function()
 DeleteEntity(safe)
 DeleteObject(safe)
 SetEntityAsNoLongerNeeded(safe)
 safepos = {["x"] = 0, ["y"] = 0, ["z"] = 0}
 TriggerServerEvent('houseRobberies:giveMoney')
end)
