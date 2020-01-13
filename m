Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A840A1392F3
	for <lists+linux-raid@lfdr.de>; Mon, 13 Jan 2020 15:00:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728512AbgAMOAk (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 13 Jan 2020 09:00:40 -0500
Received: from sonic313-16.consmr.mail.bf2.yahoo.com ([74.6.133.126]:42204
        "EHLO sonic313-16.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726976AbgAMOAk (ORCPT
        <rfc822;linux-raid@vger.kernel.org>);
        Mon, 13 Jan 2020 09:00:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=att.net; s=s1024; t=1578924039; bh=fZv6s6mxlr1vl9dZCbwJSPjFbQzm5VZn34HKJ3Ry138=; h=From:Subject:To:References:Date:In-Reply-To:From:Subject; b=JsyWNiSZZKdkMQZWmgYMyto5Ah/I3ywS/O9CK2/1cre5UmISS2JmGq9LvsE+WsFl831xy0TXI1xEbPGmitCLh7vqEAG98i8bS3yJrNtlm/rrCWu8rcu3CUXoNlwHPNhjcWXJ9Ne/gz23ZQjuRBBJBL/g/sB0w0yBi85ik/edTgs=
X-YMail-OSG: 6aiDam0VM1mZRTCsKeLh_gC5zhABKyG0OYXSej_W4cUHY3L7eTznhRLcOTYd1uv
 8PFiz2OherzzHt3jHbSrjuUiTgqF8HKmfvR_HQAMipimbKkKQB7VnIs.PxRg3hCMS1SgRDd_r12R
 QRGXKdsahnrSQspYSr46NsVBnpL7LfCTzmlXEZ1PNKrWkEfCMOyee_OlcrOzelT2wGjgkjDdSfmH
 Gumc43_z4viN0Yy5zeFf1PGiGKPw4Ihlw__jdnee7Z.fuvwdmKFGJTMtlStpT2.XRRGbxtslv4ND
 BaEESvQJI5P6liJIbDdMF4UOTNNnExxaTGVUpDRXqesifpl5QuWKdK5Q0WUOgCr9.j7guqnOjYei
 e55AxjVkW2o9KxPy5_.OJaj3jJcmhXIdKWgi_KWlGgOy5JgJJN1iR.PixmjsfiCwAuh4Rt6Y.h95
 CL69Swe6FOAFWYy0uR8qu8rWBWT6uTf3wGZwy1X1j8MvcsQ1Rb064HxjQOIjKsy0I5sfJW4oh2lC
 yNbLY6HQhN7X8CsVcHTn5mDafa99VjE_pnat.2jiI0ZowLLXIuGD21KxBIAWRc0xavbXV3bQ9T2r
 kKZ7fUFw9H_C1e3XzkI2VoN21YPxGTCJJZuXFd_pYCSAJnwlQoV3Wm9CzavdjCSLCtR4qfZx0uT8
 kBj6CBtMxJJDe3GCUFTbP1.k8tseTmEtxgdJmZAW8QaDerD_dElldepMxAO4ow1AdAjIf3I64pol
 E.5KJA3v2e1SMjzLIKmMmZSOElSIuwW5FNm.IsXzgIydYM1zUU8sGHT58hVwUcLEKubIn.uPIMj.
 8hYtMsN4rcm5Is3Fcnr0VeX.IzlLcQgfRkAtHJsEgFkvSLIrsMtApYKeBSSg12Ot2nPoKaL.OXXX
 Etaj03iBBlCvQXi6geOnEqW.BbRoUrEuNwC1ABD3UJn1wRb8WZDDSL8i1jPVJeeJAgRsJWrHEOau
 Ft_N6x3OydMyv8rWVV.NK.MMy9UwMa4LrltH5UK.bU2_Hr1KW9JP_tx0NMCfRAYf9g5qBB6hZtZ0
 hC2_VQT9DVV3F9MThwkIoKpW2dpS4yzUTHuww1WNo0FA.4IylsbFXOHH.ggKmUIccg9j49CiLG0Q
 XeUM5tvg_8.bNqNlwW9whf2x9C1eg3nnG9BWO95GNqvg8PQdP3V3TKhW1GUEd_LObKRarxMcbAlw
 CUKd8s2xZelAaalcyX7bGTRcdErk3RHjoYvzOoU76s3g.eLquzwWBHOwbKYyzlI8HDR881kXNYnq
 WYqP2qR4p4l_aIQD53nZtrUDmuGKIIpjNBuM0KCSJXsJuHPfLYlrQr1AhwJCyhZxEe_8Y6nwQpl5
 q8dibcDiMbzl5_m73rRu17IS7BnqKhm5w0Y1NsyN27tttoe6UdiImUAypJ2.A11KmZKOm8e_WB__
 nNxz4ZhRCHGty8vW8CBU-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.bf2.yahoo.com with HTTP; Mon, 13 Jan 2020 14:00:39 +0000
Received: by smtp407.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 161ff5c91bad059ee67a83f33d96ed52;
          Mon, 13 Jan 2020 14:00:34 +0000 (UTC)
From:   Leslie Rhorer <lesrhorer@att.net>
Subject: Re: mdadm not sending email
To:     John Stoffel <john@stoffel.org>, linux-raid@vger.kernel.org
References: <87skiztloo.fsf@hades.wkstn.nix>
 <6c7766cb-8698-e44e-e767-000d5dea5833@att.net>
 <24091.5497.253499.381022@quad.stoffel.home>
Message-ID: <381d32b6-eee7-63c6-7cb4-64a58a0f6796@att.net>
Date:   Mon, 13 Jan 2020 08:00:32 -0600
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <24091.5497.253499.381022@quad.stoffel.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.14873 hermes Apache-HttpAsyncClient/4.1.4 (Java/1.8.0_181)
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

	I forgot to send this out to the list.  I apologize for any duplicates.

On 1/12/2020 6:47 AM, John Stoffel wrote:
> Leslie>  ??? I recently upgraded one of my servers to Debian Buster.?
> Leslie> I have been using sSMTP as my MTA, but unfortunately it is no
> Leslie> longer maintained.? I installed msmtp, instead, but now my
> Leslie> mesages are no longer going out from mdadm.? I can run the
> Leslie> command:
>
> This is a problem with your mail setup, not with mdadm.  I suspect you
> need to configure msmtp to use TLS and/or to submit the email to port
     It is using TLS.
> 587 on att.net, where you do a full authenticated login.

     Nope, 465, which by the way is the default for SSL/TLS, and I am 
doing a full authenticated login.  Now, it is certainly arguable, 
perhaps even likely, my mail setup has a problem, but without knowing 
specifically what mdadm is sending out, I am going to be hard pressed to 
know what I need to modify in my mail setup.

     In the earlier version of mdadm, the mail utility (specified in 
/etc/mdadm/mdadm.conf) was the script /usr/bin/mdadm_notify.  I have no 
idea how or whatt he newer version f mdadm sends out.

>
> Look at the examples here:
>
> https://wiki.alpinelinux.org/wiki/Relay_email_to_gmail_(msmtp,_mailx,_sendmail
> https://wiki.debian.org/msmtp


     I had already looked at both of those, and although the 
configuration for att.net is different than for gmail, nothing jumps out 
at me.


Here is my configuration for msmtp:

# Example for a system wide configuration file

# A system wide configuration file is optional.
# If it exists, it usually defines a default account.
# This allows msmtp to be used like /usr/sbin/sendmail.
account default

# The SMTP smarthost
host outbound.att.net

# Use TLS on port 465
port 465
tls on
tls_starttls off

# Construct envelope-from addresses of the form "user@oursite.example"
#auto_from on
#maildomain att.net

from lesrhorer@att.net
user lesrhorer@att.net
auth on
password XXXXXXXXXXX

# Syslog logging with facility LOG_MAIL instead of the default LOG_USER
syslog LOG_MAIL

Mail is working on another server that still uses ssmtp.  Here is the 
configuration:

# Config file for sSMTP sendmail
#
# The person who gets all mail for userids < 1000
# Make this empty to disable rewriting.
root=lesrhorer

# The place where the mail goes. The actual machine name is required no
# MX records are consulted. Commonly mailhosts are named mail.domain.com
mailhub=outbound.att.net

# Where will the mail seem to come from?
rewriteDomain=att.net

# The full hostname
hostname=localhost

# Are users allowed to set their own From: address?
# YES - Allow the user to specify their own From: address
# NO - Use the system generated From: address
FromLineOverride=YES

AuthUser=lesrhorer@att.net
AuthPass=XXXXXXXXXXXXX
UseTLS=YES

>
> And follow the debuging info these guides give.  Once you get email

     I don't see any debugging recommendations in either document.


     One interesting thing: When I run the monitor / test command on the 
older system, sendmail complains about the mailbox being unavailable, 
but it still sends out the email.

