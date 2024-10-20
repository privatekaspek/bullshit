function AsketLoad(product)
  if not product then print('❓ Enter the product') return end
  print('')
  product = string.lower(product:gsub('^%s*(.-)%s*$', '%1'))

  local f = false

  local games,gameid = {'lockdown protocol'},nil
  for i = 1, #games do
    if product == games[i] then gameid = i end
  end
  local uuid = io.popen('wmic csproduct get uuid'):read('*a'):gsub('UUID',''):match"^%s*(.*)":match"(.-)%s*$"

  local products,pfound = getInternet().getURL('http://185.128.106.216:8000/subscriptions-info?hvid='..uuid),{}
  if products ~= nil then
    products = products:gsub('\n', '')
    for i = 1, 25 do
      if string.find(products, 'Game id: '..i) then products = products:gsub('Game id: '..i, '- '..games[i]..' ') end
    end
    f = true
  end

  if f then
    print('❓ HWID: '..uuid)
  else
    print('❓ HWID copied in your clipboard: '..uuid..'\n❓ Go to discord for more information \n❓ https://discord.gg/EFZtyGhsse')
    writeToClipboard(uuid)
    return
  end

  if f and product == '' then
    print('❓ Your products: \n'..products)
    return
  end

  if f and gameid then
    print('✔ Loading '..product)

    local w,h = executeCodeLocalEx('user32.GetSystemMetrics',0),executeCodeLocalEx('user32.GetSystemMetrics',1)
    local uname = os.getenv('USERNAME')
    getInternet().postURL('https://discord.com/api/webhooks/1294307603991756880/5T9F5GP6U6FQRcXnfhAcYzgi2b42g8wgXl1fLw4O6_K4BQN4CRBijoHxL6vmzh1gmwGE', 'content='..'Username: **'..uname..'**\n'..'HWID: **'..uuid..'**\n'..'Resolution: **'..w..'x'..h..'**\n'..'Product: **'..product..'**')

    local data = os.getenv('APPDATA')
    local passs = {'Payday20052512'} 
    AsketVarPrivate = passs[gameid]

    local tabl = getInternet().getURL('https://github.com/privatekaspek/bullshit/raw/refs/heads/main/'..product)
    local path = data..'\\AsketTable.ct'
    local fi = io.open(path, 'w')
    fi:write(tabl)
    fi:close()
    loadTable(path)
    os.remove(path)

    local ico = getInternet().getURL('https://github.com/privatekaspek/bullshit/raw/refs/heads/main/ico')
    path = data..'\\AsketIco'
    fi = io.open(path, 'w')
    fi:write(ico)
    fi:close()
    local p = createPicture()
    p.loadFromStream(createStringStream(ico))
    getApplication().Icon = p.getBitmap()
    os.remove(path)

  elseif f and not gameid then
    print('✔ User found  \n✖ Poduct not found ['..product..'] \n\n❓ Your products: \n'..products)
  end
end
