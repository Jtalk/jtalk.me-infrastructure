cloud_ipv4 = "185.243.217.86"
cloud_ipv6 = "2a03:94e0:ffff:185:243:217::86"

mail_mx  = "mx.runbox.com"
mail_spf = "v=spf1 redirect=spf.runbox.com"
mail_dkim = [
  "selector1-jtalk-me.domainkey.runbox.com",
  "selector2-jtalk-me.domainkey.runbox.com"
]
mail_dmarc = "v=DMARC1; p=none; rua=mailto:me+dmarc-rua@jtalk.me; ruf=mailto:me+dmarc-ruf@jtalk.me; fo=1; adkim=s; aspf=s"
