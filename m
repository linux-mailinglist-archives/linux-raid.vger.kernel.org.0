Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D24941385B6
	for <lists+linux-raid@lfdr.de>; Sun, 12 Jan 2020 10:48:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732536AbgALJsc (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sun, 12 Jan 2020 04:48:32 -0500
Received: from sonic316-16.consmr.mail.bf2.yahoo.com ([74.6.130.126]:43703
        "EHLO sonic316-16.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732381AbgALJsc (ORCPT
        <rfc822;linux-raid@vger.kernel.org>);
        Sun, 12 Jan 2020 04:48:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=att.net; s=s1024; t=1578822511; bh=H8wS6TIDaGdPnMtoq1QTgtygWTvyk9t75ZgFmZIvu7w=; h=Subject:To:References:From:Date:In-Reply-To:From:Subject; b=00ZrJN9FEOYBSfvJKsaJ5+KRlTdzztXWRrC9IpRpcpQ6p25vL7NI2SqPI75LZ8+6+yn/JvLy2KSD2viLR8Hkv1kQol9cszhmnpuZPQ2RXSsf9qoqaMypRjK1Cpv3VEL2mUZCAZQsNjEmu76rLtLh+NKnsvLgPyuDsph0Ad/kgeQ=
X-YMail-OSG: mL2E7G4VM1l7b6cx9kpNaVq0OZHWmXtgrg9P1zJSTZXNI80OaQE7A80IILRaQFf
 rnDMBov4l4PCXaxWE06KWSUt710O.bg1Ommcdew7xIdyLfdl8iSWjYay2HcSQxE9jP1ZOD73S.ET
 k5mAF6oRzigYEHzT_UkhcrVwE3q8zWS4bgKmuQ0g.wtHlgTE76gBPfslmYT5Ewo1K5fI0idBh0sC
 mNto3HEseYlm268uc6IvX_mix8DSTmVnGLa.mXfWoHtnidJbmoYn_v6zu_d4M0GcSd5ssAYeqAi_
 MtmHiras33KOw4TAzY.QQqnVWy7LwnPGohN_44AlP3z8A15lDO_irQmkcwwiiSXrOPMLeSI1_UXt
 2EXNUs9jSKk8EY.B8ODA_AMFaxe6t7xi7eXQ3PzBCPMAZ7wKbMiNThaJbkoDWw9rvlhkiq0xK6n0
 8f5iUAeYiYgTd6zYlhB6SWSFyO3yHlxwI7sbL_0znfVIc8UG6ZRpOV7EKlPx1eSWBB.REG.tkq.T
 qgF008u08aRoJTgQzW1OQl.aztz2th9F3LhzgHBU3SuDdp1N6JC3AJ1oBR8D_QMmI_uA3sH1Xzr3
 idwwkorGpYA53fKhIWv3yh.VYsUGOqJIPD8mphMr_VHP3bqWCitn7LMJGse6M0yEwMa1eBaIk6cc
 8TYc.nvahmyhPvUfxK.POQHRhAIM1B1J8ewnuxTPMnMpzq9SWzIBCvuPheoOTEjlwUlCFczTt_rU
 GD8_AJdRZNJ5ohvzxpcuRjiMUSyLWV5MMCj.jdpzSsUIfabGTrEkYjjAX2rR08a0t6bZcyfVClQT
 rITrUQrChWJ8SOZdUH4B8dYDn_q9f6f8R62Mhp72ZtPsaYDRgKpkT99fMuGRX9mvCApNM18VlL5E
 DIGhnq2VR0oQprMDCyTxqB3.rA3FeIb.76zu5XoH9uJXVa4g38zOSsLZKiuNHmgdGSLyKfMenwel
 JxEduaTsVnDZwxdFg_k.6sl_0r5ViT0onZnzHgRGqEjMga9HOz8KtQboe.MPTurZKMVBO1F8WLEC
 VvkRYPvey56wqV6C84jfvz40mg8ildMKhTzj7yhuvq_P9GxnivrtL9Ib5_kwsKrYz8WLG4r415WS
 SUYD.Y4lVAciEXuLF3UGexlNLOxWPt8pq10qtPA3.cTqshNRcyOU6Nqc36aD1hj2ceT6SkGmUDFW
 x4YosAxsPgMe3T6bSsA2hpIRBstVQdCT0qSTSz51g4YnhSrkgM.Qqo0NzdRR4p4YRVdVHjYDcpgr
 N0Sw1xC5drG0rB3_qlPRTwpf7jrO5ri.p_mt9GTl7HcpTENVMoZM7v.v0Yq5lO24VK5cEgpAHEPc
 rcyaOBBPUuHh2TanbTbiuYd0d7J7XuqE.Ke6UYLZ9I.ls0pwaCGfxWtnMN5ylmWGCNw--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.bf2.yahoo.com with HTTP; Sun, 12 Jan 2020 09:48:31 +0000
Received: by smtp403.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 0a5c1d3f78552b693f1d1ebd584e797f;
          Sun, 12 Jan 2020 09:48:27 +0000 (UTC)
Subject: mdadm not sending email
To:     linux-raid@vger.kernel.org
References: <87skiztloo.fsf@hades.wkstn.nix>
From:   Leslie Rhorer <lesrhorer@att.net>
Message-ID: <6c7766cb-8698-e44e-e767-000d5dea5833@att.net>
Date:   Sun, 12 Jan 2020 03:48:26 -0600
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <87skiztloo.fsf@hades.wkstn.nix>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Mailer: WebService/1.1.14873 hermes Apache-HttpAsyncClient/4.1.4 (Java/1.8.0_181)
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

 ??? I recently upgraded one of my servers to Debian Buster.? I have 
been using sSMTP as my MTA, but unfortunately it is no longer 
maintained.? I installed msmtp, instead, but now my mesages are no 
longer going out from mdadm.? I can run the command:

echo "Subject: Test: | sendmail lesrhorer@att.net

and it works.? If I try:

mdadm --monitor --scan --test -1

I get:

sendmail: the server did not accept the mail
sendmail: server message: 550 Request failed; Mailbox unavailable
sendmail: could not send mail (account default from /etc/msmtprc)

and from /var/log/mail.err:

Jan 12 03:43:40 RAID-Server msmtp: host=outbound.att.net tls=on auth=on 
user=lesrhorer@att.net from=lesrhorer@att.net 
recipients=lesrhorer@att.net smtpstatus=550 smtpmsg='550 Request failed; 
Mailbox unavailable' errormsg='the server did not accept the mail' 
exitcode=EX_UNAVAILABLE

