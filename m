Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3931E1E170C
	for <lists+linux-raid@lfdr.de>; Mon, 25 May 2020 23:22:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730454AbgEYVWr (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 25 May 2020 17:22:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728092AbgEYVWq (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 25 May 2020 17:22:46 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74A32C061A0E
        for <linux-raid@vger.kernel.org>; Mon, 25 May 2020 14:22:46 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id c3so14096128wru.12
        for <linux-raid@vger.kernel.org>; Mon, 25 May 2020 14:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:cc:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding;
        bh=bO6OWil9QustP3mXg2dHzTU0jFMZqCsbMzrz5yf//sA=;
        b=rqg/iX87q2zaksV3ko4P+aD+wPcgOu+UTaHMbfLOMqaF87SzFFkYBEHt7r5iYNjIK0
         Eg+LkiQXQT5iFn90IVNg8zm8ad2TcrzF7hcZpIEinMwccNMRvAbt47v92x95+zddZ8dH
         efne5rTGgtj4XjHYBxkL5NMzuLiKzPfqA3z/QAn9kLuBSDL4Vx1QlfABrv31Sq85sknl
         74WpFtuCHX0DHgiO2uSgrE3/Tl7wtpMoGGnLCBh5oQGaYILvTWg2pmjRvy88tHa6THxs
         YWQQ9ghJxvSjnAgQtNNsAzqTp2mU8pOWtBG3PUFNM+YdGd/i+eE5jqNJXiukG8jmoZcx
         UJmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=bO6OWil9QustP3mXg2dHzTU0jFMZqCsbMzrz5yf//sA=;
        b=NBGZ/lvQMQF52INtlKSgbO0jjSyxHuIz4i8nHIXbRjimDSeSoOMCFpIrIGKZkEIA6o
         gfrfMBJ8rWUSWVsZLDwyj2L0UaCEaovN+wkxeMtxqIzoKfPdvY8U6omf0j50ZaIxURsj
         fBURg2Q/SJLKq3QVZ5TXMOqlSotkrFIuR02+Q+gVEA//6f9p+FQK1JmNBALgOBwkafZo
         uWsUVXNxX3CZ+xIx9304+lmikKopHxu25aE5n58Lu596GNmwpAu+NveM7Hg8iQOK8QCM
         1c+/IFCCCSPY0pCeFUDliS3Wj1FFLttWtvjdW3rwlCOqsb/L6GG0JSI7ulMsw5a5hnXx
         ep8w==
X-Gm-Message-State: AOAM530F3vBKbrbu3rU1Vq+RaUtMgRTEeoJS4asbC2IvH+Nw7oEqtKX6
        q+0UIpP7XMEo3oIIn+HtnXHM/MNnpl8=
X-Google-Smtp-Source: ABdhPJwXqrbM/fgcb3hqwmWFyh9e17j1/O2hCI9GjQu6eaGxFIjoMgoemuS57y8WCx93ZLaXr4241g==
X-Received: by 2002:a5d:4b47:: with SMTP id w7mr6489151wrs.234.1590441765068;
        Mon, 25 May 2020 14:22:45 -0700 (PDT)
Received: from [192.168.188.88] ([46.28.163.233])
        by smtp.gmail.com with ESMTPSA id m3sm19350086wrn.96.2020.05.25.14.22.44
        for <linux-raid@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 May 2020 14:22:44 -0700 (PDT)
Subject: Re: help requested for mdadm grow error
Cc:     linux-raid@vger.kernel.org
References: <7d95da49-33d8-cd4d-fa3f-0f3d3074cb30@gmail.com>
 <5ECC09D6.1010300@youngman.org.uk>
 <ff4ea9cd-ab35-0990-5946-4a72d4021658@gmail.com>
 <5ECC1488.3010804@youngman.org.uk>
 <4891e1e8-aaee-b36b-4131-ca7deb34defd@gmail.com>
 <alpine.DEB.2.20.2005252132080.7596@uplift.swm.pp.se>
 <103b80fa-029f-ecdc-d470-5cc591dc8dd0@gmail.com>
 <e1a4a609-2068-b084-59a6-214c88798966@youngman.org.uk>
From:   Thomas Grawert <thomasgrawert0282@gmail.com>
Message-ID: <e1ad56b2-df70-bc6a-9a81-333230d558c2@gmail.com>
Date:   Mon, 25 May 2020 23:22:42 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <e1a4a609-2068-b084-59a6-214c88798966@youngman.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

I don't think I've got an mdadm.conf ... and everything to me looks okay 
but just not working.
>
> Next step - how far has the reshape got? I *think* you might get that 
> from "cat /proc/mdstat". Can we have that please ... I'm *hoping* it 
> says the reshape is at 0%.
>
> Cheers,
> Wol


root@nas:~# cat /proc/mdstat
Personalities : [linear] [multipath] [raid0] [raid1] [raid6] [raid5] 
[raid4] [raid10]
md0 : inactive sda1[0] sdf1[5] sde1[4] sdd1[2] sdc1[1]
       58593761280 blocks super 1.2

unused devices: <none>
root@nas:~#

nothing... the reshaping run about 5min. before power loss.

