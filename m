Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D0615B4D4C
	for <lists+linux-raid@lfdr.de>; Sun, 11 Sep 2022 12:21:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbiIKKVf (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sun, 11 Sep 2022 06:21:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbiIKKVc (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Sun, 11 Sep 2022 06:21:32 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AD12386AC
        for <linux-raid@vger.kernel.org>; Sun, 11 Sep 2022 03:21:31 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 9so6407114ljr.2
        for <linux-raid@vger.kernel.org>; Sun, 11 Sep 2022 03:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=2bA1ELElVvkgb7CiHJe2MAjhGOWorKvjNB0K+35hE18=;
        b=AuF9XBNIZb5QL91ulB9+m7PnqXL1Dfyo1OIe1IbK5uhY7FGU5QBhcVEIJYKT9HlXwl
         j3Yf24wKRB97pyA8wThOACb6pcupgRr8ATmZr2nNuYCH6kcMIXiMMdmrJ5vcyIOm29Sd
         0bdcBDTFJEJbZGIBzn2AUyKeQVKqNRJe0bWqa+SFO1ayZzyb/v2z0m6sQfLcVFZM4laO
         JiAs3roLZHO6wNWwzbdCxZ3Ap/FAf0DXrhV7xHJvFxUGQvu7U++pRsrXY2IltEHHhbtc
         AAffYJyNjFD/3S4F2fpl8DXK5mwq5I7ch6BHoqEGxH8R980FtRkXNwQAJCsUJnYd2Ke9
         cNNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=2bA1ELElVvkgb7CiHJe2MAjhGOWorKvjNB0K+35hE18=;
        b=5ca6GnnjBa9upAtJ2L0RKpoG71vX5cnwe7znb0J66ocrQxsm9ZLyW0pCSnl88F7uEw
         5KIsVNVoPIK/ooewXZW402sLTQajfJXZLPMY2UPf3PmBGSlCHgOzBO3AOVi0r2V3RXO6
         oNe+j9C32C0OPgIUEmZUbfvjJIDY9UB4NlpiS9EwKAthSz9vmiPI8WmBlop9bxoXGhjl
         8NMFjK7uIExuyBaJhHbfUAWVB/ZCYIkGGQZVynVpyqd+DZ5u6+7UFtbDKXbf7f4FwnM5
         DkyGkePyoYc5KcjQ6YUey2Z3hMLR9kMB1gDuMLCkG1ti3v1zD+ughf+f3eO2OQ1qRy2A
         4o4g==
X-Gm-Message-State: ACgBeo3Ac2iVSyq9Lqck0wJMftelYQ2N8g/W31kbOWymMxpaTGOndxZA
        Q8lsfhvv3Rt0dGGrgFVnWzhKPE4iMsNV3JX3MBqJbFxS
X-Google-Smtp-Source: AA6agR7xNDn+zS84U+HqxE9gBV6b1kGS/VH4KgPUES2cF000c/LdSG+ebWW8DGgdCnZSnE1TA+uREPtxFbEdtBPuuMY=
X-Received: by 2002:a2e:a884:0:b0:25d:d8a2:d18c with SMTP id
 m4-20020a2ea884000000b0025dd8a2d18cmr6021845ljq.305.1662891689270; Sun, 11
 Sep 2022 03:21:29 -0700 (PDT)
MIME-Version: 1.0
References: <CAJH6TXj0y_bfJ1q50S7xnTyz_4BSrgNboim9e+zK1nKZX9MR3g@mail.gmail.com>
 <73143dc1-e259-9dd1-d146-81d6c576b5d4@youngman.org.uk>
In-Reply-To: <73143dc1-e259-9dd1-d146-81d6c576b5d4@youngman.org.uk>
From:   Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Date:   Sun, 11 Sep 2022 12:21:17 +0200
Message-ID: <CAJH6TXjv72H3kgKuapBFacOt-PY7Z-eQLx-1OQS9oGmnXrFgtw@mail.gmail.com>
Subject: Re: 3 way mirror
To:     Wols Lists <antlists@youngman.org.uk>
Cc:     Linux RAID Mailing List <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Il giorno dom 11 set 2022 alle ore 12:08 Wols Lists
<antlists@youngman.org.uk> ha scritto:
> What sort of error? A new disk *may* be overkill ...

It's a smart error, saying the sector at LBA can't be read, during the
scheduled long smart test.

> Then look at the smartd output and ask yourself "do I really need a new
> disk?". I wouldn't send the new one back. Depending on how well you are
> off for disk space and SATA ports, now you've got the new disk, if the
> old one is still good I'd go for a 3-disk raid-5 plus spare. That's my
> current setup.

A new (better) disk, an SSD, would cost 150 euros. Better safe than
sorry, so usually I change disks
as soon as I get a read error. (also, this disk is around 50k hours.....)
