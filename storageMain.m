close all

LT_21 = [LT_input(1920:2016) LT_input(4896:4992) LT_input(7584:7680) LT_input(10560:10656) LT_input(13440:13536) LT_input(16416:16512) LT_input(19296:19392) LT_input(22272:22368) LT_input(25248:25344) LT_input(28128:28224) LT_input(31104:31200) LT_input(33984:34080)];

plot(LT_21)
title("Longterm storage")
figure()
p_21 = [E_pres(1920:2016) E_pres(4896:4992) E_pres(7584:7680) E_pres(10560:10656) E_pres(13440:13536) E_pres(16416:16512) E_pres(19296:19392) E_pres(22272:22368) E_pres(25248:25344) E_pres(28128:28224) E_pres(31104:31200) E_pres(33984:34080)];

plot(p_21)
title("Total production")
figure()
c_21 = [E_cres(1920:2016) E_cres(4896:4992) E_cres(7584:7680) E_cres(10560:10656) E_cres(13440:13536) E_cres(16416:16512) E_cres(19296:19392) E_cres(22272:22368) E_cres(25248:25344) E_cres(28128:28224) E_cres(31104:31200) E_cres(33984:34080)];

plot(c_21)
title("Total consumption")
figure()
s_21 = [ST_input(1920:2016) ST_input(4896:4992) ST_input(7584:7680) ST_input(10560:10656) ST_input(13440:13536) ST_input(16416:16512) ST_input(19296:19392) ST_input(22272:22368) ST_input(25248:25344) ST_input(28128:28224) ST_input(31104:31200) ST_input(33984:34080)];

plot(s_21)
title("Shortterm storage")
wd = E_total * E_p_frac_wind;

sd = E_total * E_p_frac_solar;

figure()
plot(wd)
title("Windfraction")
figure()
plot(sd)
title("Solarfraction")

