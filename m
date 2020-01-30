Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9BCF014E568
	for <lists+linux-raid@lfdr.de>; Thu, 30 Jan 2020 23:15:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726295AbgA3WPB (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 30 Jan 2020 17:15:01 -0500
Received: from sonic302-6.consmr.mail.bf2.yahoo.com ([74.6.135.45]:40056 "EHLO
        sonic302-6.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726264AbgA3WPA (ORCPT
        <rfc822;linux-raid@vger.kernel.org>);
        Thu, 30 Jan 2020 17:15:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=att.net; s=s1024; t=1580422498; bh=2KZGOKYnGUVt4LqHaFnvNvxm9h2b1LuH9rrXYHH4UJI=; h=From:Subject:To:Cc:References:Date:In-Reply-To:From:Subject; b=G7unGdwfhQedoRyOMkoL57Mj2O/ioawPWuU5fqevY/4pzUcOewznQznXe6eak4QWssM/Q8YGk/kBAD/LlU8lB7EJHHW6k2ZL8Su+f3T2qNW0MdqpvtebGU0b8jxIsRDbKRtRM7PxYC7QsOjkgiJJ8x64IE7mUXkIxpUKNx+M3Ps=
X-YMail-OSG: FKoQSv0VM1mz_Rg201YVxnCCE8QbEngV27.PekE5oMqua7Ch7WjJkXjhenNP1fd
 .TXS17kkSsbQTW9wkgCZ3VMN0OOcGxAByqAtjpQkSU6gXS2FhKBE8oBj0zOPbn791ltLTRP2hpOV
 FKe7BFjuKuvWeLC0V4K4CCr0bfChteO78isjBJNLkgIEPqyvitMxZvg6BwoZvj3otcRvL8cvSz0_
 2ZkAiiS_3kQac3lNW5oi5EdmZ3HAeewDUS64zDY5XmovOtAskhpZkDUHYgaFqa6d1.ZkM.goCghZ
 b638FEAFGxkce4k2nhZYmOAhAivn5fT0wu8C936IcHZEQakeZTvWrmjm2FaQrMAV48NWNfoMDhjC
 M.Os4gyIHspkh3d5ZK75rrHB632EjV.yK8UNatCi2ze.qAGbrP1CNlIV0dHkyn.gMwl8Wvi6tLaE
 3li8uqWMXh1y8N6lQkx6Bb1..3atA8GxwLXKgn4oDH9HDyS8gXq1PpE6jFd0voFjdV0Q20PffXOz
 s3qBLm.00LfRWjJaCtkkFbW_nPn4q9Y.9BezWLp8CyBNARewpkVvxfQxqzPvSTdAEiy5EU7DEB8W
 XRGUtlN9ZoyeE0gHBfpeEnTVMhFkssBLVYjl9i9P1wqg3_0fxHzCcNh4oQKyVP8PV2V1DIG5UIJn
 Bz3qALll_UYaC_AgCYEmJU7UIQ6cWrudQu3w7IooZYosBIKSel_yDhgxBuG3c0EHz7gPpnMpJ076
 8rmxTsAIuv2vMYLDU3r4_MxC73Zzd4VELN8rErgZPbuCSvJIR5i9jyMkh66uphvuWDR0giAhOVFp
 7w7QXEXnwK1AHFe2tGforcyaEZZqqJ9g6FmD.984tfuPeN.llsmz7fkBGiWY7tcazW7t31WoYAaP
 DaBpM8qXMfCn_.EYZ.p2MGN.mWE_Iz0UYL7lVLNrm6pOv_YduymDeCYP2VKqiD_9GzutT2MoiTRd
 X6C2H78h3lqfXO07W9Zk5GcEW8d322AzgvSRrStncxz_eJba176uOcGeWZ9_pNmK0SevhmuBej8X
 DPfMNuzghutByjGC8Mgjs.bcIM1Ywvlk8jOsSwAzXUOK_bcOVvgQ3ExOr2E.zBQReaLOPlg5ZE4e
 4r4.cF4j1KPb9yGsHIl_lv_xkyrDkiczGg6hRx8aZ9Dd0KL3QDbsN7BcTN4GJG9AiypwnnrqU6TM
 0y6hsQt3kZ2tggvCB_yTRkxU4naxubZXZvmXIq.kS5CudVRGlVKP0pXaoHuS_31r6JBVo.w8Q9MU
 HZIcKXG4rN8dsYZKI4oj7QSZmBn2h7aMUYYOlNwO8BOjRqmw4nqbF8Ya61FaGM9k1o.cJJAGeo6P
 38JX_WqD4vRE5IRAPsT1QIQluk.LKPyrD.ybliHLBdFJoE_0n.BQqqUNIzNNoBVp_mQYlMz0Hxyg
 RmMcwm8p8M23I2ic-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.bf2.yahoo.com with HTTP; Thu, 30 Jan 2020 22:14:58 +0000
Received: by smtp412.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID c726bd0f3e6aabcea6b203d9b466df13;
          Thu, 30 Jan 2020 22:14:54 +0000 (UTC)
From:   Leslie Rhorer <lesrhorer@att.net>
Subject: Re: mdadm not sending email
To:     William Morgan <therealbrewer@gmail.com>
Cc:     linux-raid@vger.kernel.org
References: <87skiztloo.fsf@hades.wkstn.nix>
 <6c7766cb-8698-e44e-e767-000d5dea5833@att.net>
 <24091.5497.253499.381022@quad.stoffel.home>
 <381d32b6-eee7-63c6-7cb4-64a58a0f6796@att.net>
 <4da133ff-f17f-cb49-20e0-7953808e54ec@att.net>
 <CALc6PW4mf0kkU2y8mPvQsM3N-EMG2kLV3Y9-8EV-XQgLBmy_YA@mail.gmail.com>
Message-ID: <9e88200d-6c49-ce3b-8a5e-3406204194a6@att.net>
Date:   Thu, 30 Jan 2020 16:14:48 -0600
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CALc6PW4mf0kkU2y8mPvQsM3N-EMG2kLV3Y9-8EV-XQgLBmy_YA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Mailer: WebService/1.1.15113 hermes Apache-HttpAsyncClient/4.1.4 (Java/1.8.0_181)
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

mdadm /dev/mdX --monitor --test

On 1/29/2020 4:56 PM, William Morgan wrote:
> How do you test this? Is there a way to simulate an issue to see if 
> the mail will be sent properly?
>
> Thanks,
> Bill
>
> On Wed, Jan 29, 2020, 14:47 Leslie Rhorer <lesrhorer@att.net 
> <mailto:lesrhorer@att.net>> wrote:
>
>          I believe I have fixed the problem.  For anyone else who runs
>     across this:
>
>     1. Add both the following ines into /etc/mdadm/mdadm.conf
>
>     MAILADDR <recipient>
>
>     MAILFROM <sender>
>
>     2. Create a symlink in /usr/sbin
>
>     cd /usr/sbin
>
>     ln -s ../bin/msmtp sendmail
>
>     On 1/13/2020 8:00 AM, Leslie Rhorer wrote:
>     >     I forgot to send this out to the list.  I apologize for any
>     > duplicates.
>     >
>     > On 1/12/2020 6:47 AM, John Stoffel wrote:
>     >> Leslie>  ??? I recently upgraded one of my servers to Debian
>     Buster.?
>     >> Leslie> I have been using sSMTP as my MTA, but unfortunately it
>     is no
>     >> Leslie> longer maintained.? I installed msmtp, instead, but now my
>     >> Leslie> mesages are no longer going out from mdadm.? I can run the
>     >> Leslie> command:
>     >>
>     >> This is a problem with your mail setup, not with mdadm.  I
>     suspect you
>     >> need to configure msmtp to use TLS and/or to submit the email
>     to port
>     >     It is using TLS.
>     >> 587 on att.net <http://att.net>, where you do a full
>     authenticated login.
>     >
>     >     Nope, 465, which by the way is the default for SSL/TLS, and
>     I am
>     > doing a full authenticated login.  Now, it is certainly arguable,
>     > perhaps even likely, my mail setup has a problem, but without
>     knowing
>     > specifically what mdadm is sending out, I am going to be hard
>     pressed
>     > to know what I need to modify in my mail setup.
>     >
>     >     In the earlier version of mdadm, the mail utility (specified in
>     > /etc/mdadm/mdadm.conf) was the script /usr/bin/mdadm_notify.  I
>     have
>     > no idea how or whatt he newer version f mdadm sends out.
>     >
>     >>
>     >> Look at the examples here:
>     >>
>     >>
>     https://wiki.alpinelinux.org/wiki/Relay_email_to_gmail_(msmtp,_mailx,_sendmail
>
>     >>
>     >> https://wiki.debian.org/msmtp
>     >
>     >
>     >     I had already looked at both of those, and although the
>     > configuration for att.net <http://att.net> is different than for
>     gmail, nothing jumps
>     > out at me.
>     >
>     >
>     > Here is my configuration for msmtp:
>     >
>     > # Example for a system wide configuration file
>     >
>     > # A system wide configuration file is optional.
>     > # If it exists, it usually defines a default account.
>     > # This allows msmtp to be used like /usr/sbin/sendmail.
>     > account default
>     >
>     > # The SMTP smarthost
>     > host outbound.att.net <http://outbound.att.net>
>     >
>     > # Use TLS on port 465
>     > port 465
>     > tls on
>     > tls_starttls off
>     >
>     > # Construct envelope-from addresses of the form
>     "user@oursite.example"
>     > #auto_from on
>     > #maildomain att.net <http://att.net>
>     >
>     > from lesrhorer@att.net <mailto:lesrhorer@att.net>
>     > user lesrhorer@att.net <mailto:lesrhorer@att.net>
>     > auth on
>     > password XXXXXXXXXXX
>     >
>     > # Syslog logging with facility LOG_MAIL instead of the default
>     LOG_USER
>     > syslog LOG_MAIL
>     >
>     > Mail is working on another server that still uses ssmtp. Here is
>     the
>     > configuration:
>     >
>     > # Config file for sSMTP sendmail
>     > #
>     > # The person who gets all mail for userids < 1000
>     > # Make this empty to disable rewriting.
>     > root=lesrhorer
>     >
>     > # The place where the mail goes. The actual machine name is
>     required no
>     > # MX records are consulted. Commonly mailhosts are named
>     mail.domain.com <http://mail.domain.com>
>     > mailhub=outbound.att.net <http://outbound.att.net>
>     >
>     > # Where will the mail seem to come from?
>     > rewriteDomain=att.net <http://att.net>
>     >
>     > # The full hostname
>     > hostname=localhost
>     >
>     > # Are users allowed to set their own From: address?
>     > # YES - Allow the user to specify their own From: address
>     > # NO - Use the system generated From: address
>     > FromLineOverride=YES
>     >
>     > AuthUser=lesrhorer@att.net <mailto:lesrhorer@att.net>
>     > AuthPass=XXXXXXXXXXXXX
>     > UseTLS=YES
>     >
>     >>
>     >> And follow the debuging info these guides give.  Once you get email
>     >
>     >     I don't see any debugging recommendations in either document.
>     >
>     >
>     >     One interesting thing: When I run the monitor / test command on
>     > the older system, sendmail complains about the mailbox being
>     > unavailable, but it still sends out the email.
>
