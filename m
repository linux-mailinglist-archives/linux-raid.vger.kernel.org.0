Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67D4463E07
	for <lists+linux-raid@lfdr.de>; Wed, 10 Jul 2019 00:53:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726458AbfGIWxM (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 9 Jul 2019 18:53:12 -0400
Received: from mail-wm1-f45.google.com ([209.85.128.45]:50869 "EHLO
        mail-wm1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726318AbfGIWxM (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 9 Jul 2019 18:53:12 -0400
Received: by mail-wm1-f45.google.com with SMTP id v15so396286wml.0
        for <linux-raid@vger.kernel.org>; Tue, 09 Jul 2019 15:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=rrERRNoZny6Mh5pEDl6N3WnPlu72NIX/ZmycgC7hUaI=;
        b=p/3ZQ5yQlZMYTcvAbva4mhs86D4pUfloxewn5RKnHut+K/Q3JYJcfH6DCokF+XLFci
         whgNtzhG4QAlKxsacrwtJhquzJxTn/DKVJp7pSriVd+b8MDj/9/D1RpoH3rNgweK5wWt
         KmoyaHT5BjCNzP4WsklwHArmuCj/zJscjtTBW6UKgKhFDnMKvm+adJuojaP43U90FPHF
         GgHl3b15mMiYaZq/eiT/0w/EWNMKkIqY9Ve+o2/O0yM42q6clFfQAoft1588h0VYBXQq
         dqR5z+cKuBG0DC74MRJqt1sxejpySImyM14BQ4e8aa1fQcBZJ02FyuNtHAZeIZD6eyUA
         1Dfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=rrERRNoZny6Mh5pEDl6N3WnPlu72NIX/ZmycgC7hUaI=;
        b=OHjozRMj+vONcbmLX+/YaN2DhF+IfvYG7vT+b3BWDrEojtkeC+iAGFdznEcdO+e4hH
         xtTkixLPf/TdGqGTrC1V3+57yTEXgPgJimP+wy22/pBSI7Fafrsu9xbN583SGqtNa2D9
         GQ0WbcL7e5KGigywL69+u6wfmCqT+HHKiLXp8HjjRSwb9YOKg7lLk3LRRDjyAmuldrv2
         ZAqWvOgBqLk4o1tjRedvEybQYIqoq0t/ji9hg/r/AmdbOPKWsI+3mdz+hMFq6FZuYAxt
         MfGucRDAKDDNgWjQxVtapx/QTZj7FL65ekH4Zcr0eVv2/MGrOee0Ng6DLvlLSnI8FPZJ
         9ldw==
X-Gm-Message-State: APjAAAVUcjl+YAXkYXa4W4li226O5kjGXt2A0apMXitS6OL+GHeq4I7a
        CcrPGJkWonGSPC5bjjQp1Rpp6rGvh8s=
X-Google-Smtp-Source: APXvYqwixmw03GeyJYETy1dV6FbW3oP0GtxcgLjpHjid7Hj1Njj2NvpVmFWyWlpwZPs1g7frKit4Cw==
X-Received: by 2002:a7b:c051:: with SMTP id u17mr1613750wmc.25.1562712789766;
        Tue, 09 Jul 2019 15:53:09 -0700 (PDT)
Received: from [192.168.1.169] (94-33-52-126.static.clienti.tiscali.it. [94.33.52.126])
        by smtp.googlemail.com with ESMTPSA id q16sm468526wra.36.2019.07.09.15.53.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jul 2019 15:53:09 -0700 (PDT)
Subject: Re: Raid 1 vs Raid 5 suggestion
To:     Reindl Harald <h.reindl@thelounge.net>, linux-raid@vger.kernel.org
References: <0155f98d-7ffc-a631-a7c5-259192c0df00@gmail.com>
 <9c7c3ae9-96a3-5a5f-a1e6-461968d7ed82@thelounge.net>
From:   Luca Lazzarin <luca.lazzarin@gmail.com>
Message-ID: <73e07abc-02d5-a0ae-4a41-c1a49939e1a0@gmail.com>
Date:   Wed, 10 Jul 2019 00:53:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <9c7c3ae9-96a3-5a5f-a1e6-461968d7ed82@thelounge.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: it-IT
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Ok, thank you for your suggestion. I'll consider it.

Luca

On 10/07/19 00:39, Reindl Harald wrote:
>
> Am 10.07.19 um 00:17 schrieb Luca Lazzarin:
>> Hi all,
>>
>> actually a server of mine has a 2x1TB Raid 1 array.
>> The disks are becoming old and to avoid possible problems I would like
>> to replace them.
>>
>> Moving from 1TB of space to 2TB could be enough, but since I have to buy
>> the new disks I am considering different possibilities, which are:
>> 1) 2x2TB Raid 1 array;
>> 2) 3x2TB Raid 1 array;
>> 3) 3x1TB Raid 5 array;
>> 4) 3x2TB Raid 5 array (I know, this will give me 4TB of space, which
>> probably are enough for the next 10 year);
>> 5) 4x1TB Raid 6 array.
>>
>> Which one, in your opinion, would the the best solution?
> RAID6 - when you plan for many years you should avoid single redundancy,
> it gives some peace of mind when you know when a rebuild is running that
> you survive aonther crahsing disk
>
> personally i would always use RAID 10 no matter if it's HDD or SSD for a
> great balance of redundancy and performance, i don#t igve a shit about
> the "wasted" space when i plan for years of use


