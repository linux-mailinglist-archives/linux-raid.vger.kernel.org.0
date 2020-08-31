Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AF40257A97
	for <lists+linux-raid@lfdr.de>; Mon, 31 Aug 2020 15:38:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726326AbgHaNiC (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 31 Aug 2020 09:38:02 -0400
Received: from sonic302-36.consmr.mail.bf2.yahoo.com ([74.6.135.235]:36451
        "EHLO sonic302-36.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726359AbgHaNh7 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>);
        Mon, 31 Aug 2020 09:37:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1598881078; bh=rEaUwHKYndtlTGQd1sVG1k+Ery/k+jQaHg2LkuM/QbA=; h=Date:From:Reply-To:Subject:References:From:Subject; b=uFX3A+WoaHWSZAVySYRqcxiLYK0O3UeemkTwhQQcVUTdLMpZzexFPBkPJRaR1o8VONnjL3s+51LOIQvWVpgB/Xzt788HUEbskvDXr3ekF8xOlw4t897V6b9MfiE2CA+hwhyKKGrgPh8hviImulEottWNUzmDcf64kEeE9UrBpGuS6y2mCD19jU5G0v8bmWcm1iIOlSOBcmUOjZvloXH83Av88I/Uv6UlnaBIr6r9jLvEUTTtLCXNYnHW0f/GME8SbgQglwk5RKsudtNoYHeGLLVks18I3eMUmHTH/CSOP7Kf9sDR7NwNNn7dEqNphRG/mythjCrk1P8x/1/vPKvtAA==
X-YMail-OSG: FBT9heUVM1m64Uq_LnJFUoRiuEzhy9A.mvS_jXRlLHUHWb9d8ZC62eofuNcFSue
 1LfUkgI63XnGVipkFRiEuR_sa96i2rSBxcETOzUitGdl4n4SKnAzwKoatqauprnAz0C6wjpENvl1
 Dh_5gQ21cRgV.c8txbKrpNlws6Mz58VE7n5oykTRLWri2cJeKMUfjxg_f0TzkeC05ZiAUZ7hotYP
 RbSLXOAcVCDAeSP.awpvyBDw4mgkF9fuaOu4Zsdatiy5HsrJ.7SAGi3QMOkK5r._UXIM_Sjz6rF0
 HbKY1cUpjOA_blzc7_PVkMkHeCb9IkKu4N3fhmWp1nTAJQyHVc0ZYLlbVx.a7zOA82yheolKpqRr
 Wp8dqZv2SP9YgMLMOZSKn5jsxO7W6rNLleLbwVRhpm4PyMSs3hFdt7ldXQ3gc3wCAzE9JqJ.5q2h
 XXcq8orKjikhd9sRe7O3oV67EzcFiMv9eV48jtm_PEwoQNifJbenufd.9YF1y_ziFRnNmwPMW8.e
 T9GPtellBrl53VNbniCo9IR7IHLI4QbnvskekwqtroKZkHDEHmsH9VSOlp0KwI_HOJxavG3Yb8ia
 PUa0drb9xBFG23KqD.L0oDGZvJ3zBquDtIwsFY0cK9S8GQ_Z1JVFYa0Qun7OhbcXf4XhO_NeGhTg
 p5rVASdF8MGYKbi5COoaJnMHNUMm.8TGXv8pARmJNAEAbRfuDkC77bheRlmNK8OCizKDfKYLeUFO
 WwDs8Fs9YiiMF53ac7kddkZbPc9I3QpWG.DvbYPEZzPi5BxXoZz.01VvPFH8WDei2Ymn5YGsVI1Y
 gf6cPS6Ctv00Elvq_dbHnGXQZoBWWOeL0yXclkHjX7VFhmdsiROw_dhkrlKnJ35.t2OXPGLshgou
 TRttEPLar8pCsH.jp4ySZK9PlJJoZwfifTXWcla2WzjCwi7BXRFZ0NQcD7av4JrGt9ezq19co2_T
 K.wcCBV3HFwVRzZUG8D8jCMpxohRt.V_8ggYDQYWjU6v.XWL65yo.KJ0RS9COGDbtnpGJgxnCrcj
 meTxiEy_8f_Y1_R2aSAl3Jp2gIvf45aAPVW5K3qhMiOgQgpJkhA45TJe9hmQIVaXeobleJ9zrfKd
 StTqWbYhlTgAG7B_9eparvEmMp8yR5joL9YjUT6rYxoow9NesBDpxvQ_HTi.Jtp8_HlX5fiZUz_i
 Rry1TAuZ4bzA5BUlRxNrnBOO9gmKmQ5rp4dGXBVZaSXth6.WkOyZsCWSdAsBVq71cokNpxgRHmUm
 LnS4NZz.zC6UrVXVzN2u_jWzDZ9H7bN68HHuhYwdQJ06r__g5Xm.6zCiD9tzRp4Q8qMahsDQm5SX
 5hwlbKH2PCmpVQydCZ6RDmsouIIDGNKe3.LU2M0czkF9.9Mok7qw5bxqMNnIqDVITcFSgaJPFcAX
 8TWtx2DPLjj.rvdSfKxR.rh13Jwb7lEPy1Mr_VN1SH7OaNPHPCCbFnMPQS1kxZI8bYRtJ_mw9iEN
 RNxWNo7llOnNHJjjk
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.bf2.yahoo.com with HTTP; Mon, 31 Aug 2020 13:37:58 +0000
Date:   Mon, 31 Aug 2020 13:35:57 +0000 (UTC)
From:   "Relief Funding." <crf5@vcdsz.net.in>
Reply-To: rosesmith@live.co.uk
Message-ID: <1893651551.616686.1598880957876@mail.yahoo.com>
Subject: Relief Funding.
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
References: <1893651551.616686.1598880957876.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.16565 YMailNodin Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/84.0.4147.135 Safari/537.36
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



Dear: Beneficiary,

An irrevocable payment guarantee of =C2=A3250,000,00 GBP has been issued by=
 the UN/ World Bank Group and the International Monetary Fund (IMF) on Covi=
d- 19 relief .

Kindly forward the below details correctly to enable us proceed on your fil=
e as instructed by IMF AND UN Monetary Unit.

1. Your Full Name:
2. Address Where You Want the Courier Company to Send Your ATM Card
To or (P.O Box) :
3. Your Age:
4. Occupation:
5. Telephone Numbers:
6. Country:

Regards.

Mr. Harry Burns.
Director ATM Payment Department
(Barclays Bank Of London Plc)
