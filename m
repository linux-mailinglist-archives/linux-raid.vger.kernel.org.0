Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5481F5FFD6A
	for <lists+linux-raid@lfdr.de>; Sun, 16 Oct 2022 08:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbiJPGKs (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sun, 16 Oct 2022 02:10:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbiJPGKq (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Sun, 16 Oct 2022 02:10:46 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46C853ED40
        for <linux-raid@vger.kernel.org>; Sat, 15 Oct 2022 23:10:45 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id e53-20020a9d01b8000000b006619152f3cdso4149054ote.0
        for <linux-raid@vger.kernel.org>; Sat, 15 Oct 2022 23:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OQx//nIMTXIuGES5wdU306SDyqo/9GYHWGhMmpKB5Ag=;
        b=WQ5pM6CkDPbJu+vP70fSiqdptJ+u9+2OciCXNMnt1mMMqihAznw4h3f3yqJt0nBh2d
         EQHnExnnr82M71wvRui86FRUh8bwVl1fWn2+lU287aOJl9Lv9H59oAGBCBwmeM4SDnjM
         m+t22VfmD4lMXp1r7l1/D0T3lNG7fhBSe/WviGFJqgXARHcrR6G82BoqrWJHWyHpkXR4
         UxVu6NZuVNmXMf3QdVIENqBXDzFGSqKjtT9Sp/0YTfbHmmjNG91pODeaaYHjzgD9lOuz
         6+8NHOJxqLTK7TVAClOn7mR2EkRn9a2jbid84NqJMgRTcHN/tvyT+S0ECZG+se3qKJ41
         h37w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OQx//nIMTXIuGES5wdU306SDyqo/9GYHWGhMmpKB5Ag=;
        b=Yj+Aod0ysCP3mGx2k4xVeSyg+dQ49uy3PXJ5xYORjOGln7KY6rtAHvudn8jaeNGKzF
         WMpSR7PUWShXNo1Ij5QkLdM/PnR3n2aCmcv1h4qBPUOlOR5TLfAb0QpF3wjfiU19x1A8
         V5ONnh28HMFtCPMhxtenraTZ4o6Mh1xBnJQYfnx1wmFj3+6KrXn6LGNjL5B9SP2uLSKA
         KbwpbttSr3XdWwqhftZ0YVe23Jlx3URViLFBYW6j5Bdqg+vV9/kT37hzWQdZTif4RFKZ
         GVlcIRjVrs4/y1c9nv8JwRutf5eTW5aHM1jUz3X65UpR+aJl+EMbVgu4Zk2J61BmceaG
         uFyQ==
X-Gm-Message-State: ACrzQf1HIDn99gdOZrwn1qhcTq7i45S90XsK/k04imbmVbR1sU3MxkIW
        eg5zDL7/ofY0krgz6cavEfy3yyvpnK1/ahOd5Lw=
X-Google-Smtp-Source: AMsMyM4cOh9hi6ZtmdYfhgh9MPi0Ku8f3PmQzRiGDu6atmIJQrdJ/iunUp9fLy+hOWLhI1bdAJ3KIPsDa8Ypo1a0s40=
X-Received: by 2002:a05:6830:2475:b0:661:b91c:f32a with SMTP id
 x53-20020a056830247500b00661b91cf32amr2496295otr.123.1665900644559; Sat, 15
 Oct 2022 23:10:44 -0700 (PDT)
MIME-Version: 1.0
Sender: lolorachida@gmail.com
Received: by 2002:a05:6838:fe29:0:0:0:0 with HTTP; Sat, 15 Oct 2022 23:10:44
 -0700 (PDT)
From:   Hassan Abdul <abdulhassanmimi973@gmail.com>
Date:   Sun, 16 Oct 2022 07:10:44 +0100
X-Google-Sender-Auth: -NGhVAqeTrj212hiTkcFQ533j38
Message-ID: <CAPDHN6qmO6N3zq80aM4EBv1YQOZ71heCG0v5jX=Ty_m++TDgEQ@mail.gmail.com>
Subject: Reply Me
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=3.1 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,LOTS_OF_MONEY,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

i am Mrs Mimi Hassan Abdul Muhammad, and i was diagnosed with  cancer
about 2 years ago,before i go for my surgery i  have to do this by helping the
Less-privileged, with this fund so If you are interested to use the
sum of US17.3Million that is in  a Finance house) in  OUAGADOUGOU
BURKINA FASO to help them, kindly get back to me for more information.
Warm Regards,
Mrs Mimi Hassan Abdul Muhammad
