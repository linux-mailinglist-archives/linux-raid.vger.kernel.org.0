Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B6FE13D81E
	for <lists+linux-raid@lfdr.de>; Thu, 16 Jan 2020 11:41:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726045AbgAPKln (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 16 Jan 2020 05:41:43 -0500
Received: from mail-vs1-f46.google.com ([209.85.217.46]:37875 "EHLO
        mail-vs1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725800AbgAPKln (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Thu, 16 Jan 2020 05:41:43 -0500
Received: by mail-vs1-f46.google.com with SMTP id x18so12379278vsq.4
        for <linux-raid@vger.kernel.org>; Thu, 16 Jan 2020 02:41:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=maGMM/fejZ9Nwd7tXBr7EW0pCuYRU7zckfkx/E8QnbQ=;
        b=o5M6rg7GoVs2Cm4PXveMmwRd3llgz/Cv3wo5m8Tb/AFBwDKS1/n2cZnmkfIa0NVW9o
         zoW009rUQEQZ+pbFOLVKgPCxh877Iez4Uymv0YnjdaclZNyJsexae4Iy1zWY0GSJVWzh
         MOxWbPtrwD1KJwABheagufICgN7ZTf5AEatlzbd7QlXvTwKltcMMG38XkEhLIEsNJv7o
         e9BZs8lEbN622Y718S0XLV2hnkcshNNCeSL0gHsB87TNvXq1T7lJKk/0YhFxnECnLoCN
         zWlJeCLeHvVAlyiojn18kfH5W+zovZIIU557ij99glheALqI3FmlX0kZ2XWym04bK7LK
         LZ1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=maGMM/fejZ9Nwd7tXBr7EW0pCuYRU7zckfkx/E8QnbQ=;
        b=EkelDssGjN6+m8paQheqaBNsmF2W6gsLujeso0KlNexIJ8L2w59ZAyen4fFdcndub5
         kkkI7JT45OBWJUfQiXlVRMFw9McMyc2/b8wp2eh2wFKUF2P2e8HeuYMdbEJVG1br6pNq
         AGAl+bZdHQYIWSV1yc0NZ/YNe1uS+uGic0x5D7C2T3VIky7cHZrrnK04CSU4PArqtrfb
         kOI7P8W8fU0e+WpjcT9Ne8JBJcCyFcsKIT2c6cMbQ5Z3Uh8s+o9HZ2CwnEfZOnf5hVLg
         M7GJP7LTtDPlECxjtB4XB6bpqbYLQaF+101ih9YnDhElYHV4VxBIoLwj4CTa/na07Rm2
         54sA==
X-Gm-Message-State: APjAAAWDdVDJ4gD8Rk0QezToOWVipoEw3T6rM66FnkBd2US9i1JveCTQ
        thP7RXPNz+uuaeqLUBYA2Notfmh9rv/VCaCWaox9DwVb
X-Google-Smtp-Source: APXvYqy4qVYYIbAw9sr80AxYEd01q9XciBOcBDtaq7cjYlx7RKlObk4qrGukSYCw6Ed58z05joe583fzxNFFby/8lC0=
X-Received: by 2002:a67:fb14:: with SMTP id d20mr1001054vsr.136.1579171302166;
 Thu, 16 Jan 2020 02:41:42 -0800 (PST)
MIME-Version: 1.0
References: <CAC4UdkbjUVSpkBM88HB0UJMqXh+Pd7CRLaya=s81xMGs-9+m_Q@mail.gmail.com>
 <5E1D6C8E.8030607@youngman.org.uk> <CAC4UdkbwYvPHgufBPjNTWzcZW0FcGgGrbmFD_k_mc-Z7NVH9Pw@mail.gmail.com>
 <5E1E5798.60406@youngman.org.uk>
In-Reply-To: <5E1E5798.60406@youngman.org.uk>
From:   Rickard Svensson <myhex2020@gmail.com>
Date:   Thu, 16 Jan 2020 11:41:30 +0100
Message-ID: <CAC4UdkazYkOq=Bj4BzU=amnQZJvWcA6KtySr424BOWPABhnQGA@mail.gmail.com>
Subject: Re: Debian Squeeze raid 1 0
To:     Wols Lists <antlists@youngman.org.uk>
Cc:     linux-raid@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hi, thanks again :)

The server is shut down, will copy the two broken disks.
I think (and hope) there has been a small amount of writing since the
problems occurred.

Unexpected problem with the names of ddrescue, but the apt-get package
in Debian called gddrescue, the program is called ddrescue.
I became uncertain because you mention that it works like dd, but it
doesn't use  if=foo of=bar  like regular dd?
Anyway the program  ddrescue --help  refers to the homepage
http://www.gnu.org/software/ddrescue/ddrescue.html  which I assume is
right one..?
And there are a lot of options, any tips on some special ones I should use?

I also wonder if it is right to let mdadm try to recover from all four
disks, the first one to stop working where three days before I
discovered it.
Isn't it better to just use three disks, the two disks that are ok,
and the last disk that got too many write errors the night before I
discovered everything?

Otherwise, you have confirmed/clarified that everything seems to work
the way I hoped.
And I will read up on all the news in mdadm, and dm-integrity sounds
interesting. Thanks!

Cheers Rickard
