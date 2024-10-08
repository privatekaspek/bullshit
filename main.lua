function AsketLoad(product)
  product = string.lower(product:gsub("^%s*(.-)%s*$", "%1"))
  print('')

  local users = loadstring(getInternet().getURL('https://raw.githubusercontent.com/sasyn-asket/bullshit/refs/heads/main/db.txt'))()

  local uuid = io.popen('wmic csproduct get uuid'):read('*a'):gsub('UUID',''):match"^%s*(.*)":match"(.-)%s*$"
  local f,fp,a = false,false

  for i = 1, #users do
    if users[i][1] == uuid then
      f = true
      a = i
      for j = 2, #users[i] do
        if product == users[i][j] then
          fp = true
        end
      end
    end
  end

  if f then
    print('❓ HWID: '..uuid)
  else
    print('❓ HWID copied in your clipboard: '..uuid..'\n❓ Go to discord for more information \n❓ https://discord.gg/EFZtyGhsse')
    writeToClipboard(uuid)
    return
  end

  if f and product == '' then
    print('❓ Your products:')
    for i = 2, #users[a] do
      print(' ✔ '..users[a][i])
    end
    return
  end

  if f and fp then
    print('✔ Loading '..product)
  elseif not f then
    print('✖ User not found \n'..uuid)
  elseif f and not fp then
    print('✔ User found  \n✖ Poduct not found ['..product..'] \n\n❓ Your products:')
    for i = 2, #users[a] do
      print(' ✔ '..users[a][i])
    end
  end
end
