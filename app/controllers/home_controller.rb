class HomeController < ApplicationController
  before_action :authenticate_user!, only: [ :personstats, :update_role, :search ]

  def index
    @result=[]
    #reset_session
    

    ###PER FAR FUNZIONARE TUTTO BISOGNA SCRIVERE SUL TERMINALE :
      #1) redis-server su un terminale
      #2) bundle exec sidekiq su un altro terminale (redis-cli --> flushall)
      #3) rails s su un terzo terminale

    #Sidekiq::Queue.all.each(&:clear)
    #Sidekiq::RetrySet.new.clear
    #Sidekiq::ScheduledSet.new.clear
    #Sidekiq::DeadSet.new.clear

    #Admin.delete_all
    #Notification.delete_all
    #TeamStat.delete_all
    #Team.delete_all
    #User.delete_all
    #Stat.delete_all
    #TeamStat.delete_all
    #Team.delete_all

  

    #BattlenetOauthService.ottieniProfilo(session[:access_token], 10548078)
    #BattlenetOauthService.ottieniProfilo(session[:access_token], 1)

=begin
    max_id = Stat.order("uid DESC").limit(1)[0].uid
    idaccount = 483181335
    tmp = BattlenetOauthService.ottieniIdGioco(session[:access_token], idaccount)
    puts "L'ID DELL'ACCOUNT ERA #{idaccount} MENTRE L'ID DEL GIOCO è #{tmp}"
    #{"nome"=>"Ninjabippo", "idBattlenet"=>483181335, "uid"=>10548078, "region"=>2, "realm"=>1}
=end

=begin
    arr = ["1","51","101","151","251","301","302","351","401","451","501","551","601","651","701","751","801","802","851","901","951","1002","1003","1004","1005","1006","1007","1008","1009","1011","1013","1014","1015","1016","1017","1018","1019","1021","1022","1023","1024","1026","1027","1028","1029","1031","1032","1036","1037","1038","1039","1040","1041","1042","1043","1045","1046","1047","1049","1050","1051","1052","1053","1054","1055","1057","1058","1059","1060","1062","1063","1064","1065","1066","1067","1068","1069","1070","1071","1072","1073","1075","1076","1077","1078","1079","1080","1081","1082","1083","1084","1085","1086","1087","1088","1089","1091","1092","1095","1096","1097","1099","1100","1101","1104","1105","1106","1108","1109","1110","1111","1112","1115","1116","1117","1118","1119","1120","1121","1122","1123","1126","1127","1128","1129","1130","1131","1132","1134","1135","1136","1137","1138","1139","1140","1142","1143","1144","1145","1146","1151","1152","1153","1154","1155","1156","1157","1158","1159","1160","1161","1162","1164","1165","1166","1168","1169","1170","1171","1172","1173","1174","1175","1177","1179","1180","1182","1183","1184","1185","1186","1188","1189","1190","1191","1192","1194","1195","1196","1197","1198","1199","1200","1201","1202","1204","1206","1208","1209","1210","1212","1213","1214","1215","1216","1218","1219","1220","1221","1223","1224","1225","1226","1227","1228","1229","1230","1231","1233","1234","1236","1237","1238","1241","1242","1243","1244","1245","1246","1247","1248","1250","1252","1253","1256","1257","1258","1259","1260","1261","1262","1263","1265","1266","1268","1269","1271","1272","1273","1274","1276","1277","1278","1279","1283","1284","1285","1286","1287","1288","1289","1290","1293","1294","1297","1298","1299","1301","1302","1303","1305","1307","1309","1310","1311","1312","1314","1315","1316","1317","1318","1320","1321","1322","1323","1324","1325","1326","1329","1332","1333","1334","1336","1337","1338","1351","1352","1353","1354","1355","1356","1357","1358","1359","1360","1361","1362","1364","1365","1366","1367","1368","1369","1370","1371","1372","1373","1375","1376","1377","1378","1379","1380","1381","1382","1383","1384","1385","1386","1387","1388","1389","1390","1391","1392","1393","1394","1395","1396","1399","1400","1401","1402","1403","1404","1406","1407","1408","1409","1410","1411","1412","1413","1414","1415","1416","1417","1418","1419","1420","1421","1422","1424","1425","1426","1427","1428","1429","1430","1431","1433","1434","1435","1436","1437","1439","1440","1441","1442","1443","1444","1445","1446","1447","1448","1449","1450","1451","1452","1453","1454","1455","1456","1457","1458","1459","1460","1462","1463","1464","1465","1466","1467","1468","1469","1470","1472","1473","1474","1475","1476","1477","1478","1479","1480","1481","1482","1483","1485","1486","1487","1488","1489","1490","1491","1492","1493","1494","1495","1496","1497","1498","1499","1500","1501","1502","1503","1504","1506","1508","1509","1510","1511","1512","1513","1514","1515","1519","1520","1521","1522","1524","1525","1527","1528","1529","1530","1531","1532","1533","1534","1535","1536","1537","1538","1539","1540","1541","1542","1543","1544","1545","1546","1547","1548","1549","1550","1551","1552","1553","1554","1555","1556","1557","1558","1559","1560","1561","1562","1563","1564","1565","1566","1567","1568","1569","1572","1573","1574","1575","1576","1577","1578","1579","1580","1581","1582","1583","1584","1585","1587","1588","1591","1592","1593","1594","1596","1597","1598","1599","1600","1601","1602","1603","1604","1605","1606","1607","1608","1609","1610","1611","1612","1613","1614","1615","1616","1617","1618","1619","1620","1621","1622","1623","1625","1626","1627","1628","1629","1630","1631","1632","1634","1635","1637","1638","1639","1640","1641","1642","1643","1644","1645","1646","1648","1649","1650","1651","1652","1653","1654","1655","1656","1657","1658","1659","1700","1701","1702","1703","1704","1705","1706","1707","1708","1709","1710","1711","1712","1713","1714","1715","1718","1719","1720","1721","1722","1723","1724","1725","1726","1727","1728","1729","1730","1731","1732","1733","1734","1735","1736","1737","1738","1739","1740","1741","1742","1743","1744","1745","1746","1747","1748","1750","1751","1752","1753","1754","1756","1757","1758","1759","1760","1761","1762","1763","1764","1765","1766","1767","1768","1769","1770","1771","1800","1801","1802","1803","1900","1901","1902","1903","1904","1905","1906","1907","1908","1909","1910","1911","1912","1913","1914","1915","1916","1917","1918","1919","1920","1921","1922","1923","1925","1927","1928","1930","1931","1932","1934","1935","1936","1937","1938","1939","1940","1941","1942","1943","1944","1945","1946","1947","1949","1950","1951","1952","1953","1954","1955","1956","1957","1958","1959","1960","1961","1962","1963","1964","1965","1966","1967","1968","1969","1970","1971","2000","2001","2002","2003","2100","2102","2103","2200","2201","2202","2203","2204","2205","2206","2207","2208","2209","2210","2211","2212","2213","2214","2215","2216","2217","2218","2219","2220","2221","2222","2223","2224","2225","2226","2227","2228","2229","2230","2231","2233","2234","2235","2236","2237","2238","2239","2240","2241","2242","2243","2244","2245","2246","2247","2248","2249","2250","2251","2252","2253","2254","2255","2256","2257","2258","2259","2260","2261","2263","2264","2265","2266","2267","2268","2269","2270","2271","2272","2273","2300","2301","2302","2304"]

    a1 = arr.slice(0,100)
    a2 = arr.slice(100,200)
    a3 = arr.slice(200,300)
    a4 = arr.slice(300,400)
    a5 = arr.slice(400,500)
    a6 = arr.slice(500,600)
    a7 = arr.slice(600,700)
    a8 = arr.slice(700,788)

    BackgroundJob.perform_async(session[:access_token], a1, 1596, "1")
    BackgroundJob.perform_async(session[:access_token], a2, 1596, "2")
    BackgroundJob.perform_async(session[:access_token], a3, 1596, "3")
    BackgroundJob.perform_async(session[:access_token], a4, 1596, "4")
    BackgroundJob.perform_async(session[:access_token], a5, 1596, "5")
    BackgroundJob.perform_async(session[:access_token], a6, 1596, "6")
    BackgroundJob.perform_async(session[:access_token], a7, 1596, "7")
    BackgroundJob.perform_async(session[:access_token], a8, 1596, "8")
=end
=begin
    arr = ["1354", "1615", "1618", "1712", "1914", "1321", "1939", "1269", "1588", "1596", "1315", "1396", "1159", "1356"]

    a1 = arr.slice(0,2)
    a2 = arr.slice(2,4)
    a3 = arr.slice(4,6)
    a4 = arr.slice(6,8)
    a5 = arr.slice(8,10)
    a6 = arr.slice(10,11)
    a7 = arr.slice(11,12)
    a8 = arr.slice(12,13)


    BackgroundJob.perform_async(session[:access_token], a1, 1596, "1", "8", 100)
    BackgroundJob.perform_async(session[:access_token], a2, 1596, "2", "8", 100)
    BackgroundJob.perform_async(session[:access_token], a3, 1596, "3", "8", 100)
    BackgroundJob.perform_async(session[:access_token], a4, 1596, "4", "8", 100)
    BackgroundJob.perform_async(session[:access_token], a5, 1596, "5", "8", 100)
    BackgroundJob.perform_async(session[:access_token], a6, 1596, "6", "8", 100)
    BackgroundJob.perform_async(session[:access_token], a7, 1596, "7", "8", 100)
    BackgroundJob.perform_async(session[:access_token], a8, 1596, "8", "8", 100)
=end

    #BackgroundJob.perform_async(session[:access_token], 1269, 1269, "1")

=begin
    a = 2321
    interval = 10
    BackgroundJob.perform_async(session[:access_token], a, a+interval, "1", 8, interval)
    a = a + interval
    BackgroundJob.perform_async(session[:access_token], a, a+interval, "2", 8, interval)
    a = a + interval
    BackgroundJob.perform_async(session[:access_token], a, a+interval, "3", 8, interval)
    a = a + interval
    BackgroundJob.perform_async(session[:access_token], a, a+interval, "4", 8, interval)
    a = a + interval
    BackgroundJob.perform_async(session[:access_token], a, a+interval, "5", 8, interval)
    a = a + interval
    BackgroundJob.perform_async(session[:access_token], a, a+interval, "6", 8, interval)
    a = a + interval
    BackgroundJob.perform_async(session[:access_token], a, a+interval, "7", 8, interval)
    a = a + interval
    BackgroundJob.perform_async(session[:access_token], a, a+interval, "8", 8, interval)
=end

    #valori = Stat.pluck(:uid, :realm, :region)
    #lista_di_liste = valori.map { |valore| valore.map { |v| "#{v}" } }
    #lista_di_liste.each do |lista|
    #  puts lista.inspect
    #end

    #valori = Stat.pluck(:uid) # Estrae tutti i valori della colonna dal database
    #risultato = valori.map { |valore| "\"#{valore}\"" }.join(",") # Formatta i valori nel formato richiesto
    #puts risultato
  end

  def personstats
  end

  
  def update_role
    @user = User.find(params[:id])
    @user.role = params[:role]
    if @user.save
      redirect_to home_index_path, notice: 'Il ruolo è stato aggiornato con successo.'
    else
      render :edit, alert: 'Si è verificato un errore durante l\'aggiornamento del ruolo.'
    end
  end

  def search
    uid = -1
    if params[:user_uid].to_i == 0
      utente = User.find_by(nickname: params[:user_uid])
      if utente != nil
        uid = utente.uid
        BattlenetOauthService.ottieniProfilo(session[:access_token], utente.uid)
        @results = Stat.find_by(uid: uid)
        render :index
      else
        @result = nil
        render :index
      end
    else
      uid = params[:user_uid]
      BattlenetOauthService.ottieniProfilo(session[:access_token], uid)
      @results = Stat.find_by(uid: uid)
      render :index
    end
  end
end
