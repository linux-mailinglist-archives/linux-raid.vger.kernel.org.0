Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8875A180D4F
	for <lists+linux-raid@lfdr.de>; Wed, 11 Mar 2020 02:11:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727768AbgCKBLr (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 10 Mar 2020 21:11:47 -0400
Received: from sonic308-6.consmr.mail.bf2.yahoo.com ([74.6.130.45]:42132 "EHLO
        sonic308-6.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727528AbgCKBLq (ORCPT
        <rfc822;linux-raid@vger.kernel.org>);
        Tue, 10 Mar 2020 21:11:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=att.net; s=s1024; t=1583889105; bh=EA+wnzbB4cEQluEv7r4stQ3dTc3ZcCxRlY3UTiHSPi4=; h=Subject:From:To:References:Date:In-Reply-To:From:Subject; b=LsCIeKiDuoNtGoWz1P1feEDhUCA1koWO5WwHFiIgPm3gLJiodBJP7m42YVjCqKZ9AH6uLmvODnBhkkmE3z/k55NPVGYT5nVRxlVAYsHhn6hcjgDXlcovbRV8bueT77m6ANQibzshTLprKBc19b9QCFsmIOt54haZCEpdiO4jwV4=
X-YMail-OSG: QGvT45AVM1kIzl0Q88XW8JzeZolvbjVQZ5bNqMWOed6e4C3AhqrCNxNlYNQxCEZ
 5IGwQiI_Zjx.Iq3UIulIgqQhETiGjyA8J7W78hPyBAHPcxHAfKhMvOqJkAeY53vUqb3oMv8cHVyL
 imOMSVCpoTijGHD7D2qJl6pxYJYgBqw33IFd1SayIL4JsGVSZsFrvMpy16wn90cnq4ad7_dBaq2t
 gacuUtzqo5eN5w3GxCig19Jwc0eGaOp8f5YJ.QyeE7FbSXr8cwCnnzJtwSCwmn6HQ4wltFz6l.No
 k6WStE9EBZ6Uc79uK6x_rxvlKxeO4bXrX_NMYbV6Fy1kYGUUyf7LUlWBMiqk4MLbBNMntzfaRMRr
 QPRjm93Ix_AYoO7pb_P7tQfgdwqw9d7KaSrfBkAo6RxJjGbdX6Qm4SyBWDCxYNZcvrh5z_4qzHaf
 _YnVJhZWRw510CKzyNzv1rq59QCS0pmQpbEbMaZKq6auhLn85xPY9e4vlj1.6p4wPNTTRG_nNNf5
 T7ioOr1ngSiBgYbki8yd7BMS8y8ltYfVF4YEWfYqrDmqRp9zwakwN37ixHaF0BPx3roJI1dadyzp
 _Chhn_Uiab_y4vduVOaA.7PIYw7cmwdg92zJLnbmIAcAOrGkYm4JrhjY0Vqg4mdQBaRjKj5Utg_1
 L5ztPdh0IZozLPKitCxKGMPf3nQJrGhPQNvKf7OQuKthybyhBcH4wpIco0N6f1ECtWLpta6fnFl5
 JVcKwF70dLXBq4w7APVglt_feWXpTJNtEiGI3kdp0Et3_QpeU9VuPTRYd4Qv_h.zn5VCWkyl39.w
 Nz2KRpdTL0CrVgp1mZO51lsPN1oeGE45iDmInWErplHYrOR5kjEvC3t4bg_NZnQ3GkVjmCT8dTQU
 hwyh2C.RfqwTb9Q4F9kUex8n5hyGRpk_PC5XbobBDf8hab3LLLb52p9lZRJzJ.qp0BYinhHbC8fq
 kR6qFsvsnfMX6oAI3tvGsSKrgZU1lqC3Xi3fgzcY2jb1K4H22XDd_iNqcwaK5v5lqURw1dPD0YJM
 gTV7CdSAKywCbWvreUMBZxcQoNLzTjuoSVftMlW1hNME_W0zsQLUTIED.j3Qw8d.r_mwU3opd2s1
 7sUoSbx4LOKDOOn63cQzLOfOKqsbX61Hm4Os_eXOkojdFpzNWkqFJcmBMVk8GM8YbktoB7YF.gH5
 tEw613CfVJzSY4dXVHRCCwkIIizpXTXcf7groSpc_zPliAG6DNbBgm7WxjFRpD9hqoaucRVhfWHE
 GQhoKh63FxPT_hPJ0hcixox2yxy09WzvDLjLHwJeemxrUGXNPLod76qJ73US7_533PvASroeyp5Z
 YXwHjpF8mer6BFntxO8hR_MK5e7yxJMpDtmPQcHbgxFKro.BzMe8uOn5QiKqVG.SU7w--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.bf2.yahoo.com with HTTP; Wed, 11 Mar 2020 01:11:45 +0000
Received: by smtp420.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID e0d75464e09fdace5e5f3afb09c6605a;
          Wed, 11 Mar 2020 01:11:40 +0000 (UTC)
Subject: Re: checkarray not running or emailing
From:   Leslie Rhorer <lesrhorer@att.net>
To:     linux-raid@vger.kernel.org
References: <814aad65-fba3-334c-c4df-6b8f4bfc4193.ref@att.net>
 <814aad65-fba3-334c-c4df-6b8f4bfc4193@att.net>
Message-ID: <0ef54c89-b486-eb0b-8d70-a043ef089c9f@att.net>
Date:   Tue, 10 Mar 2020 20:11:36 -0500
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <814aad65-fba3-334c-c4df-6b8f4bfc4193@att.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Mailer: WebService/1.1.15342 hermes Apache-HttpAsyncClient/4.1.4 (Java/1.8.0_241)
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

     Is there seriously no one here who knows how checkarray was 
launched in previous versions?

On 3/1/2020 3:03 PM, Leslie Rhorer wrote:
>     I have upgraded 2 of my servers to Debian Buster, and now neither 
> one seems to be running checkarray automatically.  In addition, when I 
> run checkarray manually, it isn't sending update emails on the status 
> of the job.  Actually, I have never been able to figure out how 
> checkarray runs.  One my older servers, there doesn't seem to be 
> anything in /etc/crontab, /etc/cron.monthly, /etc/init.d/, 
> /etc/mdadm/mdadm.conf, or /lib/systemd/system/ that would run checkarray.
