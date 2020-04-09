Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E98B01A2FCA
	for <lists+linux-raid@lfdr.de>; Thu,  9 Apr 2020 09:11:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726538AbgDIHLp (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 9 Apr 2020 03:11:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:43510 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725795AbgDIHLo (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Thu, 9 Apr 2020 03:11:44 -0400
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8D8A42075E
        for <linux-raid@vger.kernel.org>; Thu,  9 Apr 2020 07:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586416303;
        bh=L8379jMzWVt6ulm41FBFQKFSTWms6lq/0QjcyqBRXkg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WFnkQChww3DT+j/2OLQ4AfMn4uP2GiwPziA/cCcqi4X95iSGzPdDS5CWGFh1tlS6f
         eb5bTPJuOd5pvZJ5fd17axOHtWQzQofCAXXrFSBrf0UJ6P9XCaEQOSMy7ap5P5sTGz
         otmiwYzqcoyqPsWF4SfE6Wv0wr6A6xpfHQ9Moj7Y=
Received: by mail-lj1-f180.google.com with SMTP id 142so5793921ljj.7
        for <linux-raid@vger.kernel.org>; Thu, 09 Apr 2020 00:11:43 -0700 (PDT)
X-Gm-Message-State: AGi0PuZVuXY9ynSTY+5eA4bHNu4owqf6xmjkmG9GDE6taPvJ1d2Wgu+/
        EnQa08Tudp4ZOiIo7AP+/8HGjHlvE3+V/A6z6eE=
X-Google-Smtp-Source: APiQypLLj7NYc+AoOAWESS83m9VKNjgDKngk2rZmHe1jVUH124aPKALSDhQ66O5hS/O/2rb6cvk1/aMEI0I9C1uMfwM=
X-Received: by 2002:a2e:89c5:: with SMTP id c5mr7004389ljk.48.1586416301744;
 Thu, 09 Apr 2020 00:11:41 -0700 (PDT)
MIME-Version: 1.0
References: <CAH6h+heYBA5RvBH7GPJ6JkPUYvjxT2A4f_gBVs=Pr-ps6rPRQw@mail.gmail.com>
In-Reply-To: <CAH6h+heYBA5RvBH7GPJ6JkPUYvjxT2A4f_gBVs=Pr-ps6rPRQw@mail.gmail.com>
From:   Song Liu <song@kernel.org>
Date:   Thu, 9 Apr 2020 00:11:30 -0700
X-Gmail-Original-Message-ID: <CAPhsuW4UTJZHSQRHt3V2oPAkz8KD1YpG2YNBBg20cBujTCnzug@mail.gmail.com>
Message-ID: <CAPhsuW4UTJZHSQRHt3V2oPAkz8KD1YpG2YNBBg20cBujTCnzug@mail.gmail.com>
Subject: Re: MD Array 'stat' File - Sectors Read
To:     Marc Smith <msmith626@gmail.com>
Cc:     linux-raid <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Mon, Mar 30, 2020 at 1:55 PM Marc Smith <msmith626@gmail.com> wrote:
>
> Hi,
>
> Apologies in advance, as I'm sure this question has been asked many
> times and there is a standard answer, but I can't seem to find it on
> forums or this mailing list.
>
> I've always observed this behavior using 'iostat', when looking at
> READ throughput numbers, the value is about 4 times more than the real
> throughput number. Knowing this, I typically look at the member
> devices to determine what throughput is actually being achieved (or
> from the application driving the I/O).
>
> Looking at the sectors read field in the 'stat' file for an MD array
> block device:
> # cat /sys/block/md127/stat && sleep 1 && cat /sys/block/md127/stat
> 93591416        0 55082801792        0       93        0        0
>   0        0        0        0        0        0        0        0
> 93608938        0 55092996456        0       93        0        0
>   0        0        0        0        0        0        0        0
>
> 55092996456 - 55082801792 = 10194664
> 10194664 * 512 = 5219667968
> 5219667968 / 1024 / 1024 = 4977
>
> This device definitely isn't doing 4,977 MiB/s. So now my curiosity is
> getting to me: Is this just known/expected behavior for the MD array
> block devices? The numbers for WRITE sectors is always accurate as far
> as I can tell. Or something configured strangely on my systems?
>
> I'm using vanilla Linux 5.4.12.

Thanks for the report. Could you please share output of

   mdadm --detial /dev/md127

and

   cat /proc/mdstat

Song
