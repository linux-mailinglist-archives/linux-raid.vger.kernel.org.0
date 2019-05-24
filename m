Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56C4529F66
	for <lists+linux-raid@lfdr.de>; Fri, 24 May 2019 21:53:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403939AbfEXTxh (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 24 May 2019 15:53:37 -0400
Received: from mail-wm1-f45.google.com ([209.85.128.45]:50578 "EHLO
        mail-wm1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403797AbfEXTxg (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Fri, 24 May 2019 15:53:36 -0400
Received: by mail-wm1-f45.google.com with SMTP id f204so10519711wme.0
        for <linux-raid@vger.kernel.org>; Fri, 24 May 2019 12:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kapcom-gr.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=KYNWyRFxvTVOS5m++RAgP0LOuDf3wa4D3xZZF5m4MTI=;
        b=PKBJeEbvNzGMqqN1DCuoNsvEVhnevC9CqWjcgiT3E0SKelB2OxEQCDoJcbs79v+zGE
         XiWkpcYkUkM4FeWfjgwyrE8Z2f7CseTywS/7dnFqBjro9cETi1tk/gEMSB/7sLxi3pLY
         E5XxguhREgrzcRtor//nKyZtzaZOwlv4WoE2vqrE795oYKJpTJlltBVWJ05uRZdLIaeY
         BKpAPUnCjkW/FFsouK3DF1bwwFHiIuyz5g8XgLFXFv0QBQB6g6BZBPgQJn63HTEdQMS3
         M2pBQz6xBfEySPMKPzANgYwh7Cz9+fNOrvNtJPaubiI3A0O8fbUU3Zv92Lt0XnCmjBbp
         veKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=KYNWyRFxvTVOS5m++RAgP0LOuDf3wa4D3xZZF5m4MTI=;
        b=tUQML4ayD20DZp/r+V2IVo1tOhqb9IpLy63eElRPuiDtQ/gAaWeDpw9pQ4SGf0S7hk
         oSntds5l/fl4ApzuP8IaptKSQFEC2czjUNJtBPL/vLPBmOeaQT6RLNzWKS+fbeuMVfxx
         PJJpKCfwB68oqV0OwT8BfvyYCB20UmB+wMy1K7/fqb3KzykrpJfanjSqsTXDvElOdS0S
         d3jaWyBRFhOZp8gagW7YKVPTE0YD3ZIBZwSbu8Ujc3APuY1FGQRhww6x85dywZIm5Tz9
         328Mn70u2BMiaobJRQR7cZD2ORGHBfCIlsuqpnLHptyw0dz/pDDpm9VhCdZHV9UbuIuu
         Y7sw==
X-Gm-Message-State: APjAAAXm5y6Bwv0cUVWvfm9OyRkeL0kiGk1Wdi3PrpmsO4/R/bKiLNQI
        FahUKpxRcC9P5pXE2io56ph6td2+LeI=
X-Google-Smtp-Source: APXvYqzXi0ctKN5Bldc/IPx096z5NvECyqLqOZrjkuF1LMIlFhkVk/5B/E7sHeaPCiYh2tB+FbaYOw==
X-Received: by 2002:a7b:cd12:: with SMTP id f18mr11839526wmj.103.1558727614135;
        Fri, 24 May 2019 12:53:34 -0700 (PDT)
Received: from ?IPv6:2a02:2149:860c:d00:9d54:bd6e:b21e:c42e? ([2a02:2149:860c:d00:9d54:bd6e:b21e:c42e])
        by smtp.gmail.com with ESMTPSA id h17sm3895494wrq.79.2019.05.24.12.53.32
        for <linux-raid@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 May 2019 12:53:33 -0700 (PDT)
Subject: Re: help recovering raid5 after degraded to 2 disks and then i/o
 errors on 1 of the 2
From:   Emmanouil Kapernaros <manolis@kapcom.gr>
To:     linux-raid@vger.kernel.org
References: <03b7485d-703f-3f33-13b7-e2b7754ab343@kapcom.gr>
Message-ID: <7d068b02-a1a9-3390-6b5b-e009291fedf8@kapcom.gr>
Date:   Fri, 24 May 2019 22:53:31 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <03b7485d-703f-3f33-13b7-e2b7754ab343@kapcom.gr>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

For future viewers of my initial mail, after some days of reading the
wiki, I finally recovered all my files using the method that is
described at
https://raid.wiki.kernel.org/index.php/Recovering_a_damaged_RAID.

I overlayed the two disks with the most recent Events count (not the
spare one) to files and I force assembled the array from these files. I
was extremely happy when I saw that the array was successfully assembled
and the Events count matched. I immediately backed up all my files
successfully.

Best wishes and..

Don't panic.


