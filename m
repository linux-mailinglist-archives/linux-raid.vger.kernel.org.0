Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB19780C0C
	for <lists+linux-raid@lfdr.de>; Sun,  4 Aug 2019 20:49:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbfHDStg (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sun, 4 Aug 2019 14:49:36 -0400
Received: from mail-qt1-f172.google.com ([209.85.160.172]:36724 "EHLO
        mail-qt1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726474AbfHDStg (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Sun, 4 Aug 2019 14:49:36 -0400
Received: by mail-qt1-f172.google.com with SMTP id z4so78988367qtc.3
        for <linux-raid@vger.kernel.org>; Sun, 04 Aug 2019 11:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=pNKj7artEawAQ0udXLn9AcIfdW9pEKpTsEuh5wtnCXM=;
        b=AqbhunzlygmtUJzqnT8xKrHvIIi/ymw8pK8Z6wWjHxPt9rqeYxo7r64jueE/mBgVLt
         LzSI39J+dgfyEp5nZgI1Id3zdiORKZ74I6cm7zKZmuGwIoxyE6OffZPBjULzBC9I/HJc
         LUiU9GKKt09DbJ8TuCBOn8wwhkAGOSa3d+9bp9/6wAjSV0uFBCqxlnzY56Vvs//kmX5A
         ZrP41IuQ5wQte7r9D1JbMwg1eRNMv6jN1ijLBHrJAqkeUj6O4/KbKgYXUU5cz4hJNCSE
         XK4D3E3uN3RuX0SbHpy9vUngR29koh3YI1eZ+fZXKHke7GJXboyzpdBJrLdBNrXGwHos
         wTDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=pNKj7artEawAQ0udXLn9AcIfdW9pEKpTsEuh5wtnCXM=;
        b=Qho5VPJoTB8qAph5oE5yaS9xXkGfYpX0t0pJyG4PSv8/W2Rf/0EFy0ISHm8TxCtkF8
         EXwIwvf5hdJG1A4R3NYDQbxawKzmwdedtrINummvMXWlAZVtOLvH3ncsl72WI0Ae24Uq
         Qwxku89NYjAzvIpyZfMPvcMM1wAxvoq1JJheky8E6ZlycopJZ2thhVcJlFe3Q9bx0wBL
         Kkda6huDMmR2Hp1BkP4kkASFnJSl7+qK4uafDxn0Sb5Ztluvkm7Pa4g0LVaYCzBdkPrQ
         sMiTTvx/Z4yFMQvb3HtOfCHrRh9fZM6G/98zKq3i2rqu+F7+I6Q/9D2F9nEo2dy/xOpo
         ztrQ==
X-Gm-Message-State: APjAAAXia+RSpXyXadD5aNjl4AJ21WV1KHmJ2O3VvU52Hbbh6XE8tah9
        yJE+Dn+NVY/gHu1YiLostsb+I7pBV0A=
X-Google-Smtp-Source: APXvYqxW6M0tUCWuyHkR7M6fGN5QonjS7lZUTpUGnxqTpiF0qvDEj/DGz4lRqfBrsX15f732iYXMjg==
X-Received: by 2002:a0c:ba0b:: with SMTP id w11mr106473720qvf.71.1564944574829;
        Sun, 04 Aug 2019 11:49:34 -0700 (PDT)
Received: from [10.10.10.77] (c-73-114-170-41.hsd1.ma.comcast.net. [73.114.170.41])
        by smtp.gmail.com with ESMTPSA id l63sm34315837qkb.124.2019.08.04.11.49.33
        for <linux-raid@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 04 Aug 2019 11:49:34 -0700 (PDT)
From:   Ryan Heath <gaauuool@gmail.com>
Subject: Raid5 2 drive failure (and my spare failed too)
To:     linux-raid@vger.kernel.org
Message-ID: <8006bdd5-55df-f5f6-9e2e-299a7fd1e64a@gmail.com>
Date:   Sun, 4 Aug 2019 14:49:32 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hi all,

I have a 6 drive raid5 with two failed drives (and unbeknownst to me my 
spare died awhile back). I noticed the first failed drive a short time 
ago and got a drive to replace it (and a new spare too) but before I 
could replace it a second drive failed. I was hoping to force the array 
back online since the recently failed drive appears to be only slightly 
out of sync but get:

mdadm: /dev/md127 assembled from 4 drives - not enough to start the array.

I put some important data on this array so I'm really hoping someone can 
provide guidance to force this array online, or otherwise get this array 
back to a state allowing me to rebuild.

Many thanks


=====> Device details

# mdadm --examine /dev/sd[bceijkl]1 >> raid.status

/dev/sdb1:
           Magic : a92b4efc
         Version : 1.2
     Feature Map : 0x0
      Array UUID : 02f6f0c4:a8f5c56e:3727e29c:a19de7c0
            Name : sihnon:MediaArchive  (local to host sihnon)
   Creation Time : Wed May 13 22:12:44 2015
      Raid Level : raid5
    Raid Devices : 6

  Avail Dev Size : 7813771264 (3725.90 GiB 4000.65 GB)
      Array Size : 19534425600 (18629.48 GiB 20003.25 GB)
   Used Dev Size : 7813770240 (3725.90 GiB 4000.65 GB)
     Data Offset : 262144 sectors
    Super Offset : 8 sectors
    Unused Space : before=262064 sectors, after=1024 sectors
           State : clean
     Device UUID : 5d62e5b4:7b737514:f9dbae72:b8b8722a

     Update Time : Tue Jul 23 18:51:47 2019
        Checksum : 955857e3 - correct
          Events : 83013

          Layout : left-symmetric
      Chunk Size : 512K

    Device Role : Active device 3
    Array State : AAAAA. ('A' == active, '.' == missing, 'R' == replacing)


/dev/sdc1:
           Magic : a92b4efc
         Version : 1.2
     Feature Map : 0x0
      Array UUID : 02f6f0c4:a8f5c56e:3727e29c:a19de7c0
            Name : sihnon:MediaArchive  (local to host sihnon)
   Creation Time : Wed May 13 22:12:44 2015
      Raid Level : raid5
    Raid Devices : 6

  Avail Dev Size : 7813771264 (3725.90 GiB 4000.65 GB)
      Array Size : 19534425600 (18629.48 GiB 20003.25 GB)
   Used Dev Size : 7813770240 (3725.90 GiB 4000.65 GB)
     Data Offset : 262144 sectors
    Super Offset : 8 sectors
    Unused Space : before=262064 sectors, after=1024 sectors
           State : clean
     Device UUID : 3480130f:e92356e5:ea86116d:4b77d461

     Update Time : Wed Jul 24 12:30:48 2019
        Checksum : f22787ec - correct
          Events : 83042

          Layout : left-symmetric
      Chunk Size : 512K

    Device Role : Active device 0
    Array State : AAA.A. ('A' == active, '.' == missing, 'R' == replacing)


/dev/sde1:
           Magic : a92b4efc
         Version : 1.2
     Feature Map : 0x0
      Array UUID : 02f6f0c4:a8f5c56e:3727e29c:a19de7c0
            Name : sihnon:MediaArchive  (local to host sihnon)
   Creation Time : Wed May 13 22:12:44 2015
      Raid Level : raid5
    Raid Devices : 6

  Avail Dev Size : 7813771264 (3725.90 GiB 4000.65 GB)
      Array Size : 19534425600 (18629.48 GiB 20003.25 GB)
   Used Dev Size : 7813770240 (3725.90 GiB 4000.65 GB)
     Data Offset : 262144 sectors
    Super Offset : 8 sectors
    Unused Space : before=262064 sectors, after=1024 sectors
           State : active
     Device UUID : bebdb2e7:254a19f3:22c6f198:678aabac

     Update Time : Sun Jul  7 02:46:07 2019
        Checksum : 4f2d9e6b - correct
          Events : 38721

          Layout : left-symmetric
      Chunk Size : 512K

    Device Role : Active device 5
    Array State : AAAAAA ('A' == active, '.' == missing, 'R' == replacing)


/dev/sdi1:
           Magic : a92b4efc
         Version : 1.2
     Feature Map : 0x2
      Array UUID : 02f6f0c4:a8f5c56e:3727e29c:a19de7c0
            Name : sihnon:MediaArchive  (local to host sihnon)
   Creation Time : Wed May 13 22:12:44 2015
      Raid Level : raid5
    Raid Devices : 6

  Avail Dev Size : 7813771264 (3725.90 GiB 4000.65 GB)
      Array Size : 19534425600 (18629.48 GiB 20003.25 GB)
   Used Dev Size : 7813770240 (3725.90 GiB 4000.65 GB)
     Data Offset : 262144 sectors
    Super Offset : 8 sectors
Recovery Offset : 7397574840 sectors
    Unused Space : before=262056 sectors, after=1024 sectors
           State : clean
     Device UUID : 0021c48b:f64ed09e:61790da8:5647f07d

     Update Time : Sun Jul  7 12:56:23 2019
   Bad Block Log : 512 entries available at offset 72 sectors
        Checksum : 384d1307 - correct
          Events : 39824

          Layout : left-symmetric
      Chunk Size : 512K

    Device Role : Active device 5
    Array State : AAAAAA ('A' == active, '.' == missing, 'R' == replacing)


/dev/sdj1:
           Magic : a92b4efc
         Version : 1.2
     Feature Map : 0x0
      Array UUID : 02f6f0c4:a8f5c56e:3727e29c:a19de7c0
            Name : sihnon:MediaArchive  (local to host sihnon)
   Creation Time : Wed May 13 22:12:44 2015
      Raid Level : raid5
    Raid Devices : 6

  Avail Dev Size : 7813771264 (3725.90 GiB 4000.65 GB)
      Array Size : 19534425600 (18629.48 GiB 20003.25 GB)
   Used Dev Size : 7813770240 (3725.90 GiB 4000.65 GB)
     Data Offset : 262144 sectors
    Super Offset : 8 sectors
    Unused Space : before=262056 sectors, after=1024 sectors
           State : clean
     Device UUID : d2e15f83:7054a78d:9039968b:5f450d3b

     Update Time : Wed Jul 24 12:30:48 2019
   Bad Block Log : 512 entries available at offset 72 sectors
        Checksum : 68a9b1b - correct
          Events : 83042

          Layout : left-symmetric
      Chunk Size : 512K

    Device Role : Active device 4
    Array State : AAA.A. ('A' == active, '.' == missing, 'R' == replacing)


/dev/sdk1:
           Magic : a92b4efc
         Version : 1.2
     Feature Map : 0x0
      Array UUID : 02f6f0c4:a8f5c56e:3727e29c:a19de7c0
            Name : sihnon:MediaArchive  (local to host sihnon)
   Creation Time : Wed May 13 22:12:44 2015
      Raid Level : raid5
    Raid Devices : 6

  Avail Dev Size : 7813771264 (3725.90 GiB 4000.65 GB)
      Array Size : 19534425600 (18629.48 GiB 20003.25 GB)
   Used Dev Size : 7813770240 (3725.90 GiB 4000.65 GB)
     Data Offset : 262144 sectors
    Super Offset : 8 sectors
    Unused Space : before=262064 sectors, after=1024 sectors
           State : clean
     Device UUID : 1fae7fad:20afca9a:5aaa7456:e2ef3fe6

     Update Time : Wed Jul 24 12:30:48 2019
        Checksum : b3d6dd20 - correct
          Events : 83042

          Layout : left-symmetric
      Chunk Size : 512K

    Device Role : Active device 2
    Array State : AAA.A. ('A' == active, '.' == missing, 'R' == replacing)


/dev/sdl1:
           Magic : a92b4efc
         Version : 1.2
     Feature Map : 0x0
      Array UUID : 02f6f0c4:a8f5c56e:3727e29c:a19de7c0
            Name : sihnon:MediaArchive  (local to host sihnon)
   Creation Time : Wed May 13 22:12:44 2015
      Raid Level : raid5
    Raid Devices : 6

  Avail Dev Size : 7813771264 (3725.90 GiB 4000.65 GB)
      Array Size : 19534425600 (18629.48 GiB 20003.25 GB)
   Used Dev Size : 7813770240 (3725.90 GiB 4000.65 GB)
     Data Offset : 262144 sectors
    Super Offset : 8 sectors
    Unused Space : before=262064 sectors, after=1024 sectors
           State : clean
     Device UUID : 3530d19c:9c2f6050:940bffec:42e7d58e

     Update Time : Wed Jul 24 12:30:48 2019
        Checksum : 97de3853 - correct
          Events : 83042

          Layout : left-symmetric
      Chunk Size : 512K

    Device Role : Active device 1
    Array State : AAA.A. ('A' == active, '.' == missing, 'R' == replacing)
