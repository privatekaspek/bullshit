function AsketLoad(product)
  createTimer(1000,function() AsketLoad = nil end)
  if not product then print('❓ Enter the product') return end

  product = string.lower(product:gsub("^%s*(.-)%s*$", "%1"))
  print('')
  AsketVarPrivate = 'Payday20052512'

  local uuid = io.popen('wmic csproduct get uuid'):read('*a'):gsub('UUID',''):match"^%s*(.*)":match"(.-)%s*$"
  local str = getInternet().getURL('http://185.128.106.216:8000/subscriptions?game_id=1&hvid='..uuid)
  local uname = os.getenv('USERNAME')

  local f,fp,a = false,false

  local w,h = executeCodeLocalEx('user32.GetSystemMetrics',0),executeCodeLocalEx('user32.GetSystemMetrics',1)

  if string.len(str) >= 5 then f = true end
  if product == 'lockdown protocol' then fp = true end

  if f then
    print('❓ HWID: '..uuid)
  else
    print('❓ HWID copied in your clipboard: '..uuid..'\n❓ Go to discord for more information \n❓ https://discord.gg/EFZtyGhsse')
    writeToClipboard(uuid)
    return
  end

  if f and product == '' then
    print('❓ Your products:')
    print(' - lockdown protocol')
    return
  end

  if f and fp then
    print('✔ Loading '..product)

    getInternet().postURL('https://discord.com/api/webhooks/1294307603991756880/5T9F5GP6U6FQRcXnfhAcYzgi2b42g8wgXl1fLw4O6_K4BQN4CRBijoHxL6vmzh1gmwGE', 'content='..'Username: **'..uname..'**\n'..'HWID: **'..uuid..'**\n'..'Resolution: **'..w..'x'..h..'**\n'..'Product: **'..product..'**')

    local data = os.getenv('APPDATA')

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

  elseif not f then
    print('✖ User not found \n'..uuid)
  elseif f and not fp then
    print('✔ User found  \n✖ Poduct not found ['..product..'] \n\n❓ Your products:')
    for i = 2, #users[a] do
      print(' - '..users[a][i])
    end
  end
end
AsketLoad('')
