local myApi = {}

myApi.map=vim.api.nvim_set_keymap

function myApi.nmap(command, value)
  return myApi.map('n',command,value, {noremap=true})
end

function myApi.imap(command, value)
  return myApi.map('i',command,value, {noremap=true})
end
return myApi
